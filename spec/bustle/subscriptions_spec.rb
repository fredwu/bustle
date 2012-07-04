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

    it "gets a subscription if it already exists" do
      Subscriptions.add(publisher, subscriber).should be_kind_of(Subscription)
    end

    it "gets a subscription if it already exists" do
      expect { Subscriptions.add! publisher, subscriber }.to raise_error
    end

    it "finds a subscription" do
      subscription = Subscriptions.get publisher, subscriber

      subscription.publisher_id.should  == publisher.id
      subscription.subscriber_id.should == subscriber.id
    end

    context "remove" do
      it "removes a subscription" do
        subscription = Subscriptions.get publisher, subscriber

        Subscriptions.remove publisher, subscriber
        Subscriptions.filter.count.should == 0
      end

      it "#remove! a subscription" do
        subscription = Subscriptions.get publisher, subscriber

        Subscriptions.remove! publisher, subscriber
        Subscriptions.filter.count.should == 0
      end

      it "does not error out when removing a non-existent subscription" do
        expect { Subscriptions.remove subscriber, subscriber2 }.not_to raise_error
      end

      it "error out when removing a non-existent subscription" do
        expect { Subscriptions.remove! subscriber, subscriber2 }.to raise_error
      end
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

      it "finds subscriptions by a publisher and conditions" do
        Subscriptions.by(publisher, {
          :subscriber_id => subscriber2.id
        }).count.should == 1
      end

      it "finds subscriptions for a subscriber" do
        Subscriptions.for(subscriber).count.should == 2
      end

      it "finds subscriptions for a subscriber and conditions" do
        Subscriptions.for(subscriber, {
          :publisher_id => publisher.id
        }).count.should == 1
      end
    end
  end
end
