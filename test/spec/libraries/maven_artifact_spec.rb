require 'spec_helper'

describe MavenCookbook::Resource::MavenArtifact do
  step_into(:maven_artifact)
  context 'installs a jar artifact' do
    recipe do
      maven_artifact 'spoon' do
        version '0.2.0-SNAPSHOT'
        group_id 'com.bloomberg.inf'
      end
    end

    it do
      is_expected.to run_maven_execute('org.apache.maven.plugins:maven-dependency-plugin:2.10:get')
      .with(options: {
        'version' => '0.2.0-SNAPSHOT',
        'transitive' => true,
        'packaging' => 'jar',
        'artifactId' => 'spoon',
        'groupId' => 'com.bloomberg.inf'
      })
    end
  end
end
