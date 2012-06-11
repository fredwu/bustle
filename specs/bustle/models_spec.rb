require_relative '../spec_helper'

describe Bustle do
  STORAGES = [
    Bustle::Storage::ActiveRecord
  ]

  STORAGES.each do |storage|
    context "storage #{storage}" do
      before(:all) do
        Bustle.config { |c| c.storage = storage }
      end

      it "has correct parent classes" do
        Bustle::Activity.superclass.to_s.should == "#{Bustle.storage}::Activity"
        Bustle::Publisher.superclass.to_s.should == "#{Bustle.storage}::Publisher"
        Bustle::Subscriber.superclass.to_s.should == "#{Bustle.storage}::Subscriber"
        Bustle::Subscription.superclass.to_s.should == "#{Bustle.storage}::Subscription"
      end
    end
  end
end
