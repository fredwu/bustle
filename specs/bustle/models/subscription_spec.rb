require_relative '../../spec_helper'

module Bustle
  describe 'Subscription' do
    let(:described_class) { Subscription }

    it_behaves_like 'model'
  end
end
