require_relative '../spec_helper'

module Bustle
  describe Publishers do
    include_context 'app_resources'
    it_behaves_like 'resource_collection'
  end
end
