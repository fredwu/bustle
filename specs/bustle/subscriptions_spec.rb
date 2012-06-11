require_relative '../spec_helper'

module Bustle
  describe Subscriptions do
    include_context 'app_resources'

    let(:publisher)   { Publishers.add post }
    let(:publisher2)  { Publishers.add Dummy::Post.create!(:title => '') }
    let(:subscriber)  { Subscribers.add user }
    let(:subscriber2) { Subscribers.add Dummy::User.create!(:name => '') }

    before do
      Subscriptions.add publisher, subscriber
    end

    it "creates a subscription" do
      subscription = Subscription.to_adapter.get(1)
      subscription.publisher_id.should  == publisher.id
      subscription.subscriber_id.should == subscriber.id
    end

    it "finds a subscription" do
      subscription = Subscriptions.get publisher, subscriber
      subscription.publisher_id.should  == publisher.id
      subscription.subscriber_id.should == subscriber.id
    end

    context "finding multiple subscriptions" do
      before do
        Subscriptions.add publisher2, subscriber
        Subscriptions.add publisher, subscriber2
        Subscriptions.add publisher2, subscriber2
      end

      it "finds all subscriptions" do
        Subscriptions.filter.count.should == 4
      end

      it "finds specific subscriptions" do
        Subscriptions.filter({
          :publisher_id  => publisher.id,
          :subscriber_id => subscriber.id
        }).count.should == 1
      end

      it "finds subscriptions by a publisher" do
        Subscriptions.by(publisher).count.should == 2
      end

      it "finds subscriptions for a subscriber" do
        Subscriptions.for(subscriber).count.should == 2
      end
    end
  end
end
