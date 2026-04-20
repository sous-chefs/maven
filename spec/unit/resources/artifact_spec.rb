# frozen_string_literal: true

require 'spec_helper'

describe 'maven_artifact' do
  step_into :maven_artifact
  platform 'ubuntu', '24.04'

  context 'with the install action' do
    let(:cached_file) do
      ::File.join(
        ENV.fetch('HOME', Dir.home),
        '.m2', 'repository', 'org/apache/commons', 'commons-lang3', '3.17.0', 'commons-lang3-3.17.0.jar'
      )
    end

    before do
      allow_any_instance_of(Chef::Provider).to receive(:shell_out!).and_return(double('shell_out'))
      allow(::File).to receive(:exist?).and_call_original
      allow(::File).to receive(:exist?).with(cached_file).and_return(true)
      allow(::File).to receive(:exist?).with('/srv/maven-artifacts/commons-lang3-3.17.0.jar').and_return(true)
      allow(::Dir).to receive(:exist?).and_call_original
      allow(::Dir).to receive(:exist?).with('/srv/maven-artifacts').and_return(true)
      allow(Digest::SHA256).to receive_message_chain(:file, :hexdigest).and_return('abc123')
    end

    recipe do
      maven_artifact 'commons-lang3' do
        group_id 'org.apache.commons'
        version '3.17.0'
        dest '/srv/maven-artifacts'
      end
    end

    it 'creates the destination directory via a ruby_block without managing directory mode' do
      expect(chef_run.find_resource(:ruby_block, 'create destination directory /srv/maven-artifacts')).to be
    end

    it { is_expected.to_not create_directory('/srv/maven-artifacts') }
  end

  context 'with the delete action' do
    recipe do
      maven_artifact 'commons-logging-custom' do
        artifact_id 'commons-logging'
        group_id 'commons-logging'
        version '1.3.5'
        dest '/srv/maven-artifacts'
        action :delete
      end
    end

    it { is_expected.to delete_file('/srv/maven-artifacts/commons-logging-1.3.5.jar') }
    it { is_expected.to delete_file('/srv/maven-artifacts/commons-logging-custom.jar') }
  end
end
