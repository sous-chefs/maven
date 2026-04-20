# frozen_string_literal: true

require 'spec_helper'

describe 'maven_settings' do
  step_into :maven_settings
  platform 'ubuntu', '24.04'

  context 'when updating a setting' do
    before do
      allow(::File).to receive(:read).and_call_original
      allow(::File).to receive(:read).with('/usr/local/maven/conf/settings.xml').and_return(
        '<settings><localRepository>/root/.m2/repository</localRepository></settings>'
      )
      allow(::File).to receive(:write)
    end

    recipe do
      maven_settings 'settings.localRepository' do
        value '/srv/maven/.m2/repository'
      end
    end

    it { is_expected.to install_chef_gem('nori') }
    it { is_expected.to install_chef_gem('gyoku') }

    it 'rewrites the settings file with the requested value' do
      expect(::File).to receive(:write).with(
        '/usr/local/maven/conf/settings.xml',
        a_string_including('/srv/maven/.m2/repository')
      )

      chef_run
    end
  end

  context 'when the setting is already current' do
    before do
      allow(::File).to receive(:read).and_call_original
      allow(::File).to receive(:read).with('/usr/local/maven/conf/settings.xml').and_return(
        '<settings><localRepository>/srv/maven/.m2/repository</localRepository></settings>'
      )
      allow(::File).to receive(:write)
    end

    recipe do
      maven_settings 'settings.localRepository' do
        value '/srv/maven/.m2/repository'
      end
    end

    it 'does not rewrite the file' do
      expect(::File).not_to receive(:write)

      chef_run
    end
  end
end
