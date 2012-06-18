require_relative '../../spec_helper'

module Bustle
  describe 'Subscriber' do
    let(:described_class) { Subscriber }

    include_context 'app_resources'
    it_behaves_like 'model'
    it_behaves_like 'has_activities'
  end
end
