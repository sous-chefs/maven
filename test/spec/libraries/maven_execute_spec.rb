require 'spec_helper'

describe MavenCookbook::Resource::MavenExecute do
  step_into(:maven_execute)
  context 'with archetype:generate' do
    recipe do
      maven_execute 'archetype:generate'
    end

    it { is_expected.to run_execute('mvn archetype:generate') }
  end

  context 'with some options' do
    recipe do
      maven_execute 'archetype:generate' do
        options do
          artifactId 'foo'
          groupId 'bar'
        end
      end
    end

    it { is_expected.to run_execute('mvn archetype:generate -DartifactId=foo -DgroupId=bar') }
  end
end
