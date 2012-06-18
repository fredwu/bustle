shared_examples 'has_activities' do
  context "activities" do
    let(:publisher)  { Bustle::Publishers.add post }
    let(:subscriber) { Bustle::Subscribers.add user }

    before do
      Bustle::Subscriptions.add publisher, subscriber
    end

    it "has activities" do
      2.times { publisher.publish }

      publisher.activities.count.should == 2
      subscriber.activities.count.should == 2
    end
  end
end