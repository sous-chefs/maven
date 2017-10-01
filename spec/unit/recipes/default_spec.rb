require 'spec_helper'

describe 'maven::default' do
  context 'When the platform doesn\'t matter' do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'includes the ark recipe' do
      expect(chef_run).to include_recipe('ark::default')
    end
  end

  context 'On a non-Windows platform' do
    context 'When Maven owner and group are not important' do
      cached(:chef_run) do
        runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
        runner.converge(described_recipe)
      end

      it 'writes the `/etc/mavenrc`' do
        expect(chef_run).to create_template('/etc/mavenrc')
          .with(source: 'mavenrc.erb')
          .with(mode: '0755')
      end
    end

    context 'When Maven owner and group are not overriden' do
      cached(:chef_run) do
        runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
          node.automatic['maven']['version'] = '1.2.3'
          node.automatic['maven']['url'] = 'https://maven/maven.tar.gz'
          node.automatic['maven']['checksum'] = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef'
          node.automatic['maven']['m2_home'] = '/home/maven-user'
          node.automatic['maven']['setup_bin'] = false
        end
        runner.converge(described_recipe)
      end

      it 'does not create a group' do
        expect(chef_run).to_not create_group('create the group for Maven')
      end

      it 'does not create a user' do
        expect(chef_run).to_not create_user('create the user for Maven')
      end

      it 'downloads ark' do
        expect(chef_run).to install_ark('maven')
          .with(version: '1.2.3')
          .with(url: 'https://maven/maven.tar.gz')
          .with(checksum: '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef')
          .with(home_dir: '/home/maven-user')
          .with(win_install_dir: '/home/maven-user')
          .with(append_env_path: false)
          .with(owner: 'root')
          .with(group: 'root')
      end
    end

    context 'When Maven owner and group are overriden' do
      cached(:chef_run) do
        runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
          node.automatic['maven']['version'] = '1.2.3'
          node.automatic['maven']['url'] = 'https://maven/maven.tar.gz'
          node.automatic['maven']['checksum'] = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef'
          node.automatic['maven']['m2_home'] = '/home/maven-user'
          node.automatic['maven']['setup_bin'] = false
          node.automatic['maven']['user'] = 'maven-user'
          node.automatic['maven']['group'] = 'maven-group'
        end
        runner.converge(described_recipe)
      end

      it 'creates a group' do
        expect(chef_run).to create_group('create the group for Maven')
          .with(group_name: 'maven-group')
      end

      it 'creates a user' do
        expect(chef_run).to create_user('create the user for Maven')
          .with(username: 'maven-user')
          .with(manage_home: true)
          .with(group: 'maven-group')
      end

      it 'downloads ark' do
        expect(chef_run).to install_ark('maven')
          .with(version: '1.2.3')
          .with(url: 'https://maven/maven.tar.gz')
          .with(checksum: '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef')
          .with(home_dir: '/home/maven-user')
          .with(win_install_dir: '/home/maven-user')
          .with(append_env_path: false)
          .with(owner: 'maven-user')
          .with(group: 'maven-group')
      end
    end
  end

  context 'On a Windows platform' do
    context 'When Maven owner and group are not important' do
      cached(:chef_run) do
        runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '7') do |node|
          node.automatic['maven']['m2_home'] = 'C:\Users\Maven-User'
          node.automatic['maven']['mavenrc']['opts'] = '-Ddummy=true'
        end
        runner.converge(described_recipe)
      end

      it 'sets the M2_HOME environment variable' do
        expect(chef_run).to create_env('M2_HOME')
          .with(value: 'C:\Users\Maven-User')
      end

      it 'sets the M2_OPTS' do
        expect(chef_run).to create_env('MAVEN_OPTS')
          .with(value: '-Ddummy=true')
      end
    end

    context 'When Maven owner and group are not overriden' do
      cached(:chef_run) do
        runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '7') do |node|
          node.automatic['maven']['version'] = '1.2.3'
          node.automatic['maven']['url'] = 'https://maven/maven.tar.gz'
          node.automatic['maven']['checksum'] = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef'
          node.automatic['maven']['m2_home'] = 'C:\Users\Maven-User'
          node.automatic['maven']['setup_bin'] = false
        end
        runner.converge(described_recipe)
      end

      it 'does not create a group' do
        expect(chef_run).to_not create_group('create the group for Maven')
      end

      it 'does not create a user' do
        expect(chef_run).to_not create_user('create the user for Maven')
      end

      it 'downloads ark' do
        expect(chef_run).to install_ark('maven')
          .with(version: '1.2.3')
          .with(url: 'https://maven/maven.tar.gz')
          .with(checksum: '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef')
          .with(home_dir: 'C:\Users\Maven-User')
          .with(win_install_dir: 'C:\Users\Maven-User')
          .with(append_env_path: false)
          .with(owner: 'Administrator')
          .with(group: 'Administrators')
      end
    end

    context 'When Maven owner and group are overriden' do
      cached(:chef_run) do
        runner = ChefSpec::ServerRunner.new(platform: 'windows', version: '7') do |node|
          node.automatic['maven']['version'] = '1.2.3'
          node.automatic['maven']['url'] = 'https://maven/maven.tar.gz'
          node.automatic['maven']['checksum'] = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef'
          node.automatic['maven']['m2_home'] = 'C:\Users\Maven-User'
          node.automatic['maven']['setup_bin'] = false
          node.automatic['maven']['user'] = 'Wibble'
          node.automatic['maven']['group'] = 'Group'
        end
        runner.converge(described_recipe)
      end

      it 'creates a group' do
        expect(chef_run).to create_group('create the group for Maven')
          .with(group_name: 'Group')
      end

      it 'creates a user' do
        expect(chef_run).to create_user('create the user for Maven')
          .with(username: 'Wibble')
          .with(manage_home: true)
          .with(group: 'Group')
      end

      it 'downloads ark' do
        expect(chef_run).to install_ark('maven')
          .with(version: '1.2.3')
          .with(url: 'https://maven/maven.tar.gz')
          .with(checksum: '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef')
          .with(home_dir: 'C:\Users\Maven-User')
          .with(win_install_dir: 'C:\Users\Maven-User')
          .with(append_env_path: false)
          .with(owner: 'Wibble')
          .with(group: 'Group')
      end
    end
  end
end
