require 'spec_helper'

describe MavenCookbook::Resource::MavenExecute do
  step_into(:maven_execute)
  context 'with archetype:generate' do
    recipe do
      maven_execute 'archetype:generate'
    end

    it do
      is_expected.to run_bash('mvn archetype:generate')
      .with(code: 'mvn archetype:generate')
    end
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

    it do
      is_expected.to run_bash('mvn archetype:generate')
      .with(code: 'mvn archetype:generate -DartifactId=foo -DgroupId=bar')
    end
  end
end
