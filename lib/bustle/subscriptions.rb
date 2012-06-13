module Bustle
  class Subscriptions
    RESOURCE_NAME = 'Bustle::Subscription'

    include Concern::Filterable

    class << self
      def add(publisher, subscriber)
        Subscription.to_adapter.create!(
          :publisher_id  => publisher.id,
          :subscriber_id => subscriber.id
        )
      end

      def get(publisher, subscriber)
        Subscription.to_adapter.find_first(
          :publisher_id  => publisher.id,
          :subscriber_id => subscriber.id
        )
      end

      def remove(publisher, subscriber)
        get(publisher, subscriber).destroy
      end

      def by(publisher)
        Subscription.to_adapter.find_all(
          :publisher_id  => publisher.id
        )
      end

      def for(subscriber)
        Subscription.to_adapter.find_all(
          :subscriber_id => subscriber.id
        )
      end
    end
  end
end
