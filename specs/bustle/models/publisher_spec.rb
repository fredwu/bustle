require_relative '../../spec_helper'

module Bustle
  describe 'Publisher' do
    let(:described_class) { Publisher }

    it_behaves_like 'bustle_model'
  end
end
