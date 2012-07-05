module Bustle::Concern
  module SubscriberResource
    extend ActiveSupport::Concern

    def subscriber_resource
      subscriber = Bustle::Subscriber.to_adapter.get!(self.subscriber_id)
      subscriber.resource_class.constantize.to_adapter.get!(subscriber.resource_id)
    end
  end
end
