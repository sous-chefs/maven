require 'etc'
require 'spec_helper'
require 'tmpdir'

describe 'maven custom resource' do
  let(:current_user) { Etc.getpwuid(Process.uid).name }
  let(:current_group) { Etc.getgrgid(Process.gid).name }
  let(:dest_dir) { Dir.mktmpdir('maven-dest') }
  let(:build_dir) { Dir.mktmpdir('maven-build') }
  let(:artifact_name) { 'mysql-connector-java-5.1.19.jar' }
  let(:artifact_path) { ::File.join(dest_dir, artifact_name) }
  let(:build_artifact_path) { ::File.join(build_dir, artifact_name) }

  around do |example|
    ::File.chmod(0o700, dest_dir)
    example.run
  ensure
    ::FileUtils.remove_entry(dest_dir) if ::Dir.exist?(dest_dir)
    ::FileUtils.remove_entry(build_dir) if ::Dir.exist?(build_dir)
  end

  cached(:chef_run) do
    allow(Dir).to receive(:mktmpdir).with('chef_maven_lwrp').and_yield(build_dir)
    allow_any_instance_of(Chef::Provider).to receive(:shell_out!) do |_provider, *_args, **_kwargs|
      ::File.write(build_artifact_path, 'artifact-bits')
    end

    ChefSpec::SoloRunner.new(
      platform: 'ubuntu',
      step_into: ['maven'],
      cookbook_path: [
        ::File.expand_path('../../../', __dir__),
        ::File.expand_path('../../../test/fixtures/cookbooks', __dir__),
      ]
    ) do |node|
      node.normal['maven_test']['dest'] = dest_dir
      node.normal['maven_test']['owner'] = current_user
      node.normal['maven_test']['group'] = current_group
    end.converge('test::existing_dest_mode')
  end

  it 'preserves an existing destination directory mode' do
    chef_run

    expect(::File.stat(dest_dir).mode & 0o7777).to eq(0o700)
    expect(::File.exist?(artifact_path)).to eq(true)
  end
end
