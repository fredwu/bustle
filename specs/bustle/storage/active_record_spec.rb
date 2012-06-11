require_relative '../../spec_helper'

module Bustle::Storage
  describe ActiveRecord do
    before(:all) do
      Bustle.config { |c| c.storage = ActiveRecord }
    end

    it "loads storage model files" do
      ActiveRecord.const_defined?(:Activity).should == true
      ActiveRecord.const_defined?(:Publisher).should == true
      ActiveRecord.const_defined?(:Subscriber).should == true
      ActiveRecord.const_defined?(:Subscription).should == true
    end

    it "has correct table names" do
      ActiveRecord::Activity.table_name = 'bustle_activities'
      ActiveRecord::Publisher.table_name = 'bustle_publishers'
      ActiveRecord::Subscriber.table_name = 'bustle_subscribers'
      ActiveRecord::Subscription.table_name = 'bustle_subscriptions'
    end
  end
end
