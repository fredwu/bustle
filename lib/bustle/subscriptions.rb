module Bustle
  class Subscriptions
    RESOURCE_NAME = 'Bustle::Subscription'

    include Concern::Filterable
    include Concern::ByPublisher
    include Concern::ForSubscriber

    class << self
      def add!(publisher, subscriber)
        Subscription.to_adapter.create!(
          :publisher_id  => publisher.id,
          :subscriber_id => subscriber.id
        )
      end

      def add(publisher, subscriber)
        add!(publisher, subscriber)
      rescue
        get(publisher, subscriber)
      end

      def get(publisher, subscriber)
        Subscription.to_adapter.find_first(
          :publisher_id  => publisher.id,
          :subscriber_id => subscriber.id
        )
      end

      def remove!(publisher, subscriber)
        subscription = get(publisher, subscriber)
        if subscription.nil?
          raise "Subscription between #{publisher} and #{subscriber} does not exist therefore cannot be removed."
        else
          subscription.destroy
        end
      end

      def remove(publisher, subscriber)
        subscription = get(publisher, subscriber)
        subscription.destroy unless subscription.nil?
      end
    end
  end
end
