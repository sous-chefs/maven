# frozen_string_literal: true

require 'spec_helper'

describe 'maven_artifact' do
  step_into :maven_artifact
  platform 'ubuntu', '24.04'

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
