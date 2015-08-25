#
# Cookbook: maven
# License: Apache 2.0
#
# Copyright 2010-2013, Chef Software, Inc.
# Copyright 2015, Bloomberg Finance L.P.
#
require 'poise'

module MavenCookbook
  module Resource
    # A resource which manages Maven artifacts.
    # @since 2.0.0
    class MavenArtifact < Chef::Resource
      include Poise(fused: true)
      provides(:maven_artifact)

      attribute(:artifact_id, kind_of: String, name_attribute: true)
      attribute(:classifier, kind_of: String)
      attribute(:group_id, kind_of: String)
      attribute(:packaging, equal_to: %w{jar war pom}, default: 'jar')
      attribute(:repositories, kind_of: [String, Array])
      attribute(:transitive, equal_to: [true, false], default: true)
      attribute(:version, kind_of: String)

      attribute(:destination, kind_of: String)
      attribute(:owner, kind_of: String)
      attribute(:group, kind_of: String)
      attribute(:mode, kind_of: String)

      def friendly_basename
        [artifact_id, version, classifier].join('-') + '.' + packaging
      end

      action(:install) do
        repos = [new_resource.repositories].flatten.compact.join(',')

        notifying_block do
          # If the destination directory is set on the resource we
          # should attempt to create it with appropriate permissions &
          # ownership.
          directory new_resource.destination do
            recursive true
            owner new_resource.owner
            group new_resource.group
            mode '0755'
          end if new_resource.destination

          # TODO: (jbellone) It looks like that the correct maven
          # action to run here is going to be :copy or
          # :copy-dependencies. The newer version(s) of this plugin
          # are deprecating the destination bits.
          maven_execute 'org.apache.maven.plugins:maven-dependency-plugin:2.10:get' do
            directory new_resource.destination
            user new_resource.owner
            group new_resource.group
            options do
              version new_resource.version
              artifactId new_resource.artifact_id
              groupId new_resource.group_id
              dest new_resource.destination
              packaging new_resource.packaging
              transitive new_resource.transitive
              classifier new_resource.classifier
              remoteRepositories repos if new_resource.repositories
            end
          end

          file ::File.join(new_resource.destination, new_resource.friendly_basename) do
            owner new_resource.owner
            group new_resource.group
            mode new_resource.mode
          end if new_resource.destination
        end
      end
    end
  end
end
