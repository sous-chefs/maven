# frozen_string_literal: true

require_relative '../../spec_helper'

control 'maven-install-01' do
  impact 1.0
  title 'Maven is installed and runnable'

  describe file("#{maven_home}/bin/mvn") do
    it { should exist }
    it { should be_executable }
  end

  describe command("#{maven_home}/bin/mvn -version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should match(/Apache Maven 3\.9\.14/) }
  end
end

control 'maven-config-01' do
  impact 0.7
  title 'Maven environment and settings are configured'

  describe file('/etc/mavenrc') do
    it { should exist }
    its('content') { should match(%r{export M2_HOME=/usr/local/maven}) }
    its('content') { should match(/export MAVEN_OPTS=/) }
  end

  describe file("#{maven_home}/conf/settings.xml") do
    it { should exist }
    its('content') { should match(%r{/var/lib/maven/.m2/repository}) }
  end
end

control 'maven-artifact-01' do
  impact 0.7
  title 'Artifacts are downloaded to the requested destination'

  describe file("#{artifact_dir}/commons-lang3-3.17.0.jar") do
    it { should exist }
    it { should be_file }
  end

  describe file("#{artifact_dir}/commons-logging-custom.jar") do
    it { should exist }
    it { should be_file }
  end
end
