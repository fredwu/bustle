require_relative '../../spec_helper'

module Bustle
  describe 'Subscription' do
    let(:described_class) { Subscription }

    it_behaves_like 'model'
    it_behaves_like 'publisher_resource'
    it_behaves_like 'subscriber_resource'
  end
end
