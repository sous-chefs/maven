#
# Cookbook: maven
# License: Apache 2.0
#
# Copyright 2010-2012, Chef Software, Inc.
# Copyright 2015, Bloomberg Finance L.P.
#
require 'poise'

module MavenCookbook
  module Resource
    # A resource which executes Maven commands.
    # @since 2.0.0
    class MavenExecute < Chef::Resource
      include Poise(fused: true)
      provides(:maven_execute)

      attribute(:directory, kind_of: String, default: '/var/run/java')
      attribute(:user, kind_of: String)
      attribute(:group, kind_of: String)

      attribute(:command, kind_of: String, name_attribute: true)
      attribute(:environment, kind_of: Hash, default: { 'PATH' => '/usr/bin/local:/usr/bin:/bin' })
      attribute(:options, option_collector: true)

      action(:run) do
        command = ['mvn',
                   new_resource.command,
                   new_resource.options
                   .delete_if { |_, v| v.nil? }
                   .map { |k, v| "-D#{k}=#{v}" }].flatten.map(&:strip)
        notifying_block do
          directory new_resource.directory do
            recursive true
            owner new_resource.user
            group new_resource.group
            mode '0755'
          end

          execute command.join(' ') do
            cwd new_resource.directory
            environment new_resource.environment
          end
        end
      end
    end
  end
end
