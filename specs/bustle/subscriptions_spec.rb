require_relative '../spec_helper'

module Bustle
  describe Subscriptions do
    include_context 'app_resources'

    let(:publisher)  { Publishers.add post }
    let(:subscriber) { Subscribers.add user }

    it "creates a subscription" do
      Subscriptions.add publisher, subscriber

      subscription = Subscription.to_adapter.get(1)
      subscription.publisher_id.should  == publisher.id
      subscription.subscriber_id.should == subscriber.id
    end
  end
end
