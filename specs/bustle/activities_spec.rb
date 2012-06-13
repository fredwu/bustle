require_relative '../spec_helper'

module Bustle
  describe Activities do
    include_context 'app_resources'

    let(:publisher)   { Publishers.add post }
    let(:publisher2)  { Publishers.add user }
    let(:subscriber)  { Subscribers.add post }
    let(:subscriber2) { Subscribers.add user }

    it "creates an activity" do
      Activities.add publisher, 'show', comment

      activity = Activity.to_adapter.get(1)
      activity.resource_class.should  == 'Bustle::Dummy::Comment'
      activity.resource_id.should == 101
      activity.action.should == 'show'
      activity.publisher_id.should == publisher.id
    end

    context "multiple activities" do
      before do
        2.times { Activities.add publisher, 'show', comment }
        1.times { Activities.add publisher, 'reply', comment }
        2.times { Activities.add publisher2, 'reply', comment }
      end

      it "finds all activities" do
        Activities.filter.count.should == 5
      end

      context "#by" do
        it "finds all activities by a publisher" do
          Activities.by(publisher).count.should == 3
        end

        it "finds all activities filtered by conditions" do
          Activities.by(publisher, {
            :action => 'show'
          }).count.should == 2
        end
      end

      context "#for" do
        before do
          Subscriptions.add publisher, subscriber
          Subscriptions.add publisher, subscriber2
          Subscriptions.add publisher2, subscriber2
        end

        it "finds all activities for a subscriber" do
          Activities.for(subscriber).count.should == 3
          Activities.for(subscriber2).count.should == 5
        end

        it "finds all activities filtered by conditions" do
          Activities.for(subscriber2, {
            :publisher_id => publisher2.id
          }).count.should == 2
        end
      end
    end
  end
end
