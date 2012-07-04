module Bustle::Concern
  module ResourceCollection
    extend ActiveSupport::Concern

    module ClassMethods
      def add!(resource)
        self::RESOURCE_NAME.constantize.to_adapter.create!(
          :resource_class => resource.class.name,
          :resource_id    => resource.id
        )
      end

      def add(resource)
        add!(resource)
      rescue
        get(resource)
      end

      def get(resource)
        self::RESOURCE_NAME.constantize.to_adapter.find_first(
          :resource_class => resource.class.name,
          :resource_id    => resource.id
        )
      end

      def remove!(resource)
        r = get(resource)

        if r.nil?
          raise "#{resource} does not exist therefore cannot be removed."
        else
          r.destroy
        end
      end

      def remove(resource)
        get(resource).destroy
      end
    end
  end
end
