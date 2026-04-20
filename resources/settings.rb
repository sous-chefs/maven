# frozen_string_literal: true

provides :maven_settings
unified_mode true

description 'Update a value in a Maven settings.xml file by dotted path.'

property :path, String,
         name_property: true,
         description: 'Dotted path of the setting to update (e.g. "settings.localRepository").'

property :value, [String, TrueClass, FalseClass, Hash],
         required: true,
         description: 'Value to set at the given path.'

property :settings_file, String,
         default: '/usr/local/maven/conf/settings.xml',
         description: 'Absolute path to the settings.xml file.'

default_action :update

action :update do
  chef_gem 'nori' do
    compile_time true
  end

  chef_gem 'gyoku' do
    compile_time true
  end

  require 'nori'
  require 'gyoku'

  settings_file = new_resource.settings_file
  current = Nori.new(parser: :rexml).parse(::File.read(settings_file))

  *path_elements, key = new_resource.path.split('.')
  container = path_elements.inject(current, :fetch)

  if container[key] != new_resource.value
    converge_by "update #{new_resource.path} in #{settings_file}" do
      container[key] = new_resource.value
      xml = Gyoku.xml(current).gsub('xsi:nil="true"', '')
      ::File.write(settings_file, xml)
    end
  end
end
