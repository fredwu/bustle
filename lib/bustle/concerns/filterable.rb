module Bustle::Concern
  module Filterable
    extend ActiveSupport::Concern

    module ClassMethods
      def filter(options = {})
        self::RESOURCE_NAME.constantize.to_adapter.find_all(options)
      end
    end
  end
end
