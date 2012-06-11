require_relative '../../spec_helper'

module Bustle
  describe 'Subscriber' do
    let(:described_class) { Subscriber }

    it_behaves_like 'bustle_model'
  end
end
