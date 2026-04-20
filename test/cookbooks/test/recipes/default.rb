# frozen_string_literal: true

apt_update 'update' if platform_family?('debian')

package value_for_platform_family(
  'amazon' => 'java-17-amazon-corretto-headless',
  'fedora' => 'java-latest-openjdk-headless',
  'rhel' => 'java-17-openjdk-headless',
  'debian' => 'default-jdk-headless'
)

maven_install 'default'

maven_settings 'settings.localRepository' do
  value '/var/lib/maven/.m2/repository'
end

maven_artifact 'commons-lang3' do
  group_id 'org.apache.commons'
  version '3.17.0'
  dest '/usr/local/maven-artifacts'
end

maven_artifact 'commons-logging-custom' do
  artifact_id 'commons-logging'
  group_id 'commons-logging'
  version '1.3.5'
  dest '/usr/local/maven-artifacts'
  action :put
end
