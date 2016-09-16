require 'spec_helper'

describe 'default recipe' do
  cached(:chef_run) do
    runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
    runner.converge('maven::default')
  end

  it 'includes the ark recipe' do
    expect(chef_run).to include_recipe('ark::default')
  end

  it 'downloads ark' do
    expect(chef_run).to install_ark('maven')
  end

  it 'writes the `/etc/mavenrc`' do
    template = chef_run.template('/etc/mavenrc')
    expect(template).to be
    expect(template.source).to eq('mavenrc.erb')
    expect(template.mode).to eq('0755')
  end
end
