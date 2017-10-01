require 'spec_helper'

describe 'default recipe' do
  cached(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04') do |node|
      node.automatic['maven']['version'] = '1.2.3'
      node.automatic['maven']['url'] = 'https://maven/maven.tar.gz'
      node.automatic['maven']['checksum'] = '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef'
      node.automatic['maven']['m2_home'] = '/home/maven-user'
      node.automatic['maven']['setup_bin'] = false
    end
    runner.converge('maven::default')
  end

  it 'includes the ark recipe' do
    expect(chef_run).to include_recipe('ark::default')
  end

  it 'downloads ark' do
    expect(chef_run).to install_ark('maven')
      .with(version: '1.2.3')
      .with(url: 'https://maven/maven.tar.gz')
      .with(checksum: '0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef')
      .with(home_dir: '/home/maven-user')
      .with(win_install_dir: '/home/maven-user')
      .with(append_env_path: false)
  end

  it 'writes the `/etc/mavenrc`' do
    expect(chef_run).to create_template('/etc/mavenrc')
      .with(source: 'mavenrc.erb')
      .with(mode: '0755')
  end
end
