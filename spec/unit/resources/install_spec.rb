# frozen_string_literal: true

require 'spec_helper'

describe 'maven_install' do
  step_into :maven_install
  platform 'ubuntu', '24.04'

  context 'with default properties' do
    recipe do
      maven_install 'default'
    end

    it { is_expected.to install_package('tar') }

    it do
      expect(chef_run).to install_ark('maven').with(
        version: '3.9.14',
        url: 'https://archive.apache.org/dist/maven/maven-3/3.9.14/binaries/apache-maven-3.9.14-bin.tar.gz',
        home_dir: '/usr/local/maven',
        append_env_path: false,
        owner: 'root',
        group: 'root'
      )
    end

    it { is_expected.to create_link('/usr/local/bin/mvn').with(to: '/usr/local/maven/bin/mvn') }

    it do
      expect(chef_run).to create_file('/etc/mavenrc').with(
        owner: 'root',
        group: 'root',
        mode: '0755',
        content: <<~MAVENRC
          export M2_HOME=/usr/local/maven
          export MAVEN_OPTS="-Dmaven.repo.local=$HOME/.m2/repository -Xmx384m"
        MAVENRC
      )
    end
  end

  context 'when managing the user and group' do
    recipe do
      maven_install 'custom' do
        user 'maven'
        group 'maven'
        manage_user true
      end
    end

    it { is_expected.to create_group('maven') }

    it do
      expect(chef_run).to create_user('maven').with(
        gid: 'maven',
        manage_home: true,
        shell: '/bin/bash'
      )
    end
  end

  context 'when removing an installation' do
    recipe do
      maven_install 'cleanup' do
        action :remove
      end
    end

    it { is_expected.to delete_file('/etc/mavenrc') }
    it { is_expected.to delete_directory('/usr/local/maven').with(recursive: true) }
    it { is_expected.to delete_link('/usr/local/bin/mvn') }
  end
end
