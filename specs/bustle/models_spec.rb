require_relative '../spec_helper'

module Bustle
  describe 'models' do
    ['Activity', 'Publisher', 'Subscriber', 'Subscription'].each do |model|
      let(:described_class) { "Bustle::#{model}".constantize }

      it_behaves_like 'bustle_model'
    end
  end
end
