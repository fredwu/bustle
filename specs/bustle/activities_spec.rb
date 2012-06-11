require_relative '../spec_helper'

module Bustle
  describe Activities do
    include_context 'app_resources'

    let(:publisher) { Publishers.add post }

    it "creates an activity" do
      Activities.add publisher, 'show', comment

      activity = Activity.to_adapter.get(1)
      activity.resource_class.should  == 'Bustle::Dummy::Comment'
      activity.resource_id.should == 101
      activity.action.should == 'show'
      activity.publisher_id.should == publisher.id
    end
  end
end
