require_relative 'spec_helper'

describe Bustle do
  describe "configuration" do
    [:intepreter, :storage].each do |option|
      it "sets the config option #{option}" do
        Bustle.config { |c| c.send "#{option}=", 'dummy' }
        Bustle.send(option).must_equal 'dummy'
      end
    end
  end
end
