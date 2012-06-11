module Bustle
  class Subscriptions
    def self.add(publisher, subscriber)
      Subscription.to_adapter.create!(
        :publisher_id  => publisher.id,
        :subscriber_id => subscriber.id
      )
    end
  end
end
