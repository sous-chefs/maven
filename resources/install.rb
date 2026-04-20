# frozen_string_literal: true

provides :maven_install
unified_mode true

description 'Install Apache Maven from the upstream binary tarball.'

property :install_name, String,
         name_property: true,
         description: 'Identifier for this installation.'

property :version, String,
         default: '3.9.14',
         description: 'Apache Maven version to install.'

property :url, String,
         description: 'Override URL for the Maven binary tarball.'

property :checksum, String,
         description: 'SHA256 checksum of the binary tarball. Required when overriding url.'

property :install_dir, String,
         default: '/usr/local/maven',
         description: 'Directory to install Maven into.'

property :user, String,
         default: 'root',
         description: 'User that owns the installation.'

property :group, String,
         default: 'root',
         description: 'Group that owns the installation.'

property :mavenrc_path, String,
         default: '/etc/mavenrc',
         description: 'Path to write the mavenrc environment file.'

property :maven_opts, String,
         default: '-Dmaven.repo.local=$HOME/.m2/repository -Xmx384m',
         description: 'Value for MAVEN_OPTS set in mavenrc.'

property :manage_user, [true, false],
         default: false,
         description: 'Create the user and group if they do not exist.'

property :append_env_path, [true, false],
         default: true,
         description: 'Expose the mvn binary on the system PATH via /usr/local/bin/mvn.'

default_action :install

action :install do
  if new_resource.manage_user
    unless %w(root).include?(new_resource.group)
      group new_resource.group
    end

    unless %w(root).include?(new_resource.user)
      user new_resource.user do
        gid new_resource.group
        manage_home true
        shell '/bin/bash'
      end
    end
  end

  package 'tar'

  ark 'maven' do
    version new_resource.version
    url new_resource.url || default_tarball_url(new_resource.version)
    checksum new_resource.checksum if new_resource.checksum
    home_dir new_resource.install_dir
    append_env_path false
    owner new_resource.user
    group new_resource.group
  end

  link '/usr/local/bin/mvn' do
    to ::File.join(new_resource.install_dir, 'bin', 'mvn')
    action(new_resource.append_env_path ? :create : :delete)
  end

  file new_resource.mavenrc_path do
    owner new_resource.user
    group new_resource.group
    mode '0755'
    content <<~MAVENRC
      export M2_HOME=#{new_resource.install_dir}
      export MAVEN_OPTS="#{new_resource.maven_opts}"
    MAVENRC
  end
end

action :remove do
  file new_resource.mavenrc_path do
    action :delete
  end

  directory new_resource.install_dir do
    recursive true
    action :delete
  end

  link '/usr/local/bin/mvn' do
    action :delete
  end
end

action_class do
  def default_tarball_url(version)
    major = version.split('.').first
    "https://archive.apache.org/dist/maven/maven-#{major}/#{version}/binaries/apache-maven-#{version}-bin.tar.gz"
  end
end
