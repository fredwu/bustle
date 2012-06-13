require_relative '../spec_helper'

module Bustle
  describe Activities do
    include_context 'app_resources'

    let(:publisher)  { Publishers.add post }
    let(:publisher2) { Publishers.add user }

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
        3.times { Activities.add publisher, 'show', comment }
      end

      it "finds all activities" do
        Activities.filter.count.should == 3
      end

      it "finds all activities by a publisher" do
        2.times { Activities.add publisher2, 'reply', comment }

        Activities.by(publisher2).count.should == 2
      end
    end
  end
end
