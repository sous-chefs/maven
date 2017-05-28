#
# Cookbook:: maven
# Resource:: default
#
# Author:: Bryan W. Berry <bryan.berry@gmail.com>
# Copyright:: 2012-2017, Chef Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

property :artifact_id,  String, name_property: true
property :group_id,     String, required: true
property :dest,         String
property :version,      String, required: true
property :packaging,    String, default: 'jar'
property :classifier,   String
property :owner,        String, default: 'root'
property :group,        String, default: node['root_group']
property :timeout,      Integer, default: 600
property :mode,         [Integer, String], default: '0644'
property :repositories, Array, default: lazy { node['maven']['repositories'] }
property :transitive,   [true, false], default: false

alias_method :artifactId, :artifact_id
alias_method :groupId, :group_id

require 'chef/mixin/checksum'
require 'fileutils'

include Chef::Mixin::Checksum

action :install do
  get_mvn_artifact('install', new_resource)
end

action :put do
  get_mvn_artifact('put', new_resource)
end

action_class do
  def get_artifact_file_name(action, new_resource)
    artifact_file_name = if action == 'put'
                           "#{new_resource.name}.#{new_resource.packaging}"
                         elsif new_resource.classifier.nil?
                           "#{new_resource.artifact_id}-#{new_resource.version}.#{new_resource.packaging}"
                         else
                           "#{new_resource.artifact_id}-#{new_resource.version}-#{new_resource.classifier}.#{new_resource.packaging}"
                         end
    artifact_file_name
  end

  def create_command_string(artifact_file, new_resource)
    group_id = '-DgroupId=' + new_resource.group_id
    artifact_id = '-DartifactId=' + new_resource.artifact_id
    version = '-Dversion=' + new_resource.version
    dest = '-Ddest=' + artifact_file
    force_update = new_resource.version =~ /-SNAPSHOT$/ ? '-U' : ''
    repos = '-DremoteRepositories=' + new_resource.repositories.join(',')
    packaging = '-Dpackaging=' + new_resource.packaging
    classifier = '-Dclassifier=' + new_resource.classifier if new_resource.classifier
    plugin_version = '2.4'
    plugin = "org.apache.maven.plugins:maven-dependency-plugin:#{plugin_version}:get"
    transitive = '-Dtransitive=' + new_resource.transitive.to_s
    %(mvn #{force_update} #{plugin} #{group_id} #{artifact_id} #{version} #{packaging} #{classifier} #{dest} #{repos} #{transitive})
  end

  def get_mvn_artifact(action, new_resource)
    artifact_file_name = get_artifact_file_name(action, new_resource)

    Dir.mktmpdir('chef_maven_lwrp') do |tmp_dir|
      tmp_file = ::File.join(tmp_dir, artifact_file_name)
      shell_out!(create_command_string(tmp_file, new_resource), timeout: new_resource.timeout)
      dest_file = ::File.join(new_resource.dest, artifact_file_name)

      unless ::File.exist?(dest_file) && checksum(tmp_file) == checksum(dest_file)
        converge_by "#{action.capitalize} #{new_resource}" do
          directory new_resource.dest do
            recursive true
            mode '0755'
          end.run_action(:create)

          FileUtils.cp(tmp_file, dest_file, preserve: true)

          file dest_file do
            owner new_resource.owner
            group new_resource.owner
            mode new_resource.mode
          end.run_action(:create)
        end
      end
    end
  end
end
