require 'simplecov'
SimpleCov.start

require 'rspec/autorun'
require 'pry'

require File.expand_path('../../lib/bustle', __FILE__)
Dir[File.expand_path('../../lib/bustle/specs/support/**/*.rb', __FILE__)].each {|f| require f}
