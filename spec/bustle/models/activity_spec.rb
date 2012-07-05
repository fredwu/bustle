require_relative '../../spec_helper'

module Bustle
  describe 'Activity' do
    let(:described_class) { Activity }

    it_behaves_like 'model'
    it_behaves_like 'publisher_resource'
    it_behaves_like 'target_resource'
  end
end
