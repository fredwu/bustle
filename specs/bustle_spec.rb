require_relative 'spec_helper'

describe Bustle do
  context "configuration" do
    [:storage].each do |option|
      it "sets the config option #{option}" do
        Bustle.config { |c| c.send "#{option}=", 'dummy' }
        Bustle.send(option).should == 'dummy'
      end
    end
  end
end
