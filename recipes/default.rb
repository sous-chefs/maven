#
# Cookbook Name:: maven
# Recipe:: default
#
# Copyright 2011, Bryan W. Berry (<bryan.berry@gmail.com>)
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

case node[:platform]
when 'mac_os_x'
  include_recipe 'homebrew'

  user_data     = node[:etc][:passwd][node[:current_user]]
  group         = node[:etc][:group].keys.select {|group| node[:etc][:group][group][:gid] == user_data[:gid]}.first

  export_maven_var_line = "export MAVEN_OPTS=\"#{node['maven']['opts']}\""
  shellrc_path = File.join user_data[:dir], case user_data[:shell]
                                            when '/bin/bash'
                                              '.bash_profile'
                                            when '/bin/zsh'
                                              '.zshrc'
                                            end


  package 'maven' do
    version node['maven']['version']
  end

  ruby_block 'set MAVEN_OPTS in shell rc file' do
    block do
      content = nil
      File.open(shellrc_path, 'r') do |file|
        content = file.read

        maven_var_matcher = 'MAVEN_OPTS=\"[^\"]*\"'
        content.gsub! /^.*#{maven_var_matcher}.*$/, export_maven_var_line

        content << "\n\n#{export_maven_var_line}" unless content =~ /#{maven_var_matcher}/
      end

      File.open(shellrc_path, 'w') do |f|
        f.print(content)
      end

    end

    not_if do
      if node['maven']['opts'].nil?
        false
      else
        begin
          File.open(shellrc_path) do |file|
            !!(file.readlines.join("\n") =~ /#{export_maven_var_line}/)
          end
        rescue Errno::ENOENT
          false
        end
      end
    end
  end

  file "#{node['maven']['home']}/conf/settings.xml" do
    owner node[:current_user]
    group group
    mode '644'
    content to_xml(settings: node['maven']['settings'].to_hash)
  end

else
  include_recipe "java"

  include_recipe "maven::maven2"
end
