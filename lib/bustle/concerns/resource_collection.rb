module Bustle::Conern
  module ResourceCollection
    extend ActiveSupport::Concern

    module ClassMethods
      def add(resource)
        self::RESOURCE_NAME.constantize.to_adapter.create!(
          :resource_class => resource.class.name,
          :resource_id    => resource.id
        )
      end
    end
  end
end
