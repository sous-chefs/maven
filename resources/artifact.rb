# frozen_string_literal: true

provides :maven_artifact
unified_mode true

description 'Download a Maven artifact from a remote repository using the maven-dependency-plugin.'

property :artifact_id, String,
         name_property: true,
         description: 'Maven artifactId. Defaults to the resource name.'

property :group_id, String,
         required: true,
         description: 'Maven groupId.'

property :version, String,
         required: true,
         description: 'Artifact version.'

property :dest, String,
         required: true,
         description: 'Directory to place the downloaded artifact into.'

property :packaging, String,
         default: 'jar',
         description: 'Artifact packaging (jar, war, pom, etc.).'

property :classifier, String,
         description: 'Optional artifact classifier.'

property :owner, String,
         default: 'root',
         description: 'Owner of the downloaded file.'

property :group, String,
         default: lazy { node['root_group'] },
         description: 'Group of the downloaded file.'

property :mode, [Integer, String],
         default: '0644',
         description: 'Mode for the downloaded file.'

property :repositories, Array,
         default: ['https://repo1.maven.apache.org/maven2'],
         description: 'List of remote Maven repositories to try.'

property :transitive, [true, false],
         default: false,
         description: 'Whether to resolve transitive dependencies.'

property :timeout, Integer,
         default: 600,
         description: 'Timeout for the mvn invocation in seconds.'

property :plugin_version, String,
         default: '3.6.1',
         description: 'Version of maven-dependency-plugin to invoke.'

alias_method :artifactId, :artifact_id
alias_method :groupId, :group_id

default_action :install

action :install do
  fetch_artifact('install')
end

action :put do
  fetch_artifact('put')
end

action :delete do
  removable_artifact_file_names.each do |file_name|
    file ::File.join(new_resource.dest, file_name) do
      action :delete
    end
  end
end

action_class do
  def artifact_file_name(artifact_action)
    if artifact_action == 'put'
      "#{new_resource.name}.#{new_resource.packaging}"
    elsif new_resource.classifier.nil?
      "#{new_resource.artifact_id}-#{new_resource.version}.#{new_resource.packaging}"
    else
      "#{new_resource.artifact_id}-#{new_resource.version}-#{new_resource.classifier}.#{new_resource.packaging}"
    end
  end

  def removable_artifact_file_names
    %w(install put).map { |artifact_action| artifact_file_name(artifact_action) }.uniq
  end

  def mvn_command
    force_update = new_resource.version.end_with?('-SNAPSHOT') ? '-U' : ''
    plugin = "org.apache.maven.plugins:maven-dependency-plugin:#{new_resource.plugin_version}:get"
    parts = [
      'mvn', force_update, plugin,
      "-DgroupId=#{new_resource.group_id}",
      "-DartifactId=#{new_resource.artifact_id}",
      "-Dversion=#{new_resource.version}",
      "-Dpackaging=#{new_resource.packaging}",
      "-DremoteRepositories=#{new_resource.repositories.join(',')}",
      "-Dtransitive=#{new_resource.transitive}"
    ]
    parts << "-Dclassifier=#{new_resource.classifier}" if new_resource.classifier
    parts.reject { |p| p.nil? || p.empty? }.join(' ')
  end

  def fetch_artifact(artifact_action)
    require 'fileutils'
    require 'tmpdir'
    require 'digest'

    file_name = artifact_file_name(artifact_action)
    dest_dir = new_resource.dest
    dest_file = ::File.join(dest_dir, file_name)

    ruby_block "create destination directory #{dest_dir}" do
      block do
        FileUtils.mkdir_p(dest_dir)
      end
      not_if { ::Dir.exist?(dest_dir) }
    end

    shell_out!(mvn_command, timeout: new_resource.timeout)
    cached_file = cached_artifact_path

    return if ::File.exist?(dest_file) && file_sha256(cached_file) == file_sha256(dest_file)

    converge_by "#{artifact_action} maven artifact #{new_resource.group_id}:#{new_resource.artifact_id}:#{new_resource.version}" do
      FileUtils.cp(cached_file, dest_file, preserve: true)
    end

    file dest_file do
      owner new_resource.owner
      group new_resource.group
      mode new_resource.mode
    end
  end

  def file_sha256(path)
    Digest::SHA256.file(path).hexdigest
  end

  def cached_artifact_path
    exact_path = ::File.join(local_repository_path, relative_repository_path, install_file_name)
    return exact_path if ::File.exist?(exact_path)

    matches = Dir.glob(::File.join(local_repository_path, relative_repository_path, install_file_glob)).sort
    raise "Unable to locate downloaded artifact for #{artifact_coordinate}" if matches.empty?

    matches.first
  end

  def install_file_name
    if new_resource.classifier.nil?
      "#{new_resource.artifact_id}-#{new_resource.version}.#{new_resource.packaging}"
    else
      "#{new_resource.artifact_id}-#{new_resource.version}-#{new_resource.classifier}.#{new_resource.packaging}"
    end
  end

  def install_file_glob
    if new_resource.classifier.nil?
      "#{new_resource.artifact_id}-*.#{new_resource.packaging}"
    else
      "#{new_resource.artifact_id}-*-#{new_resource.classifier}.#{new_resource.packaging}"
    end
  end

  def local_repository_path
    ::File.join(ENV.fetch('HOME', Dir.home), '.m2', 'repository')
  end

  def relative_repository_path
    ::File.join(new_resource.group_id.tr('.', '/'), new_resource.artifact_id, new_resource.version)
  end

  def artifact_coordinate
    [
      new_resource.group_id,
      new_resource.artifact_id,
      new_resource.version,
      new_resource.packaging,
      new_resource.classifier,
    ].compact.join(':')
  end
end
