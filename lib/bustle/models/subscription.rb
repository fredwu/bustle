module Bustle
  class Subscription < "#{Bustle.storage}::Subscription".constantize
    include Concern::PublisherResource
    include Concern::SubscriberResource
  end
end
