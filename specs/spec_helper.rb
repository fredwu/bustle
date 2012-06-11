require 'simplecov'
SimpleCov.start

require 'rspec/autorun'
require 'factory_girl'
require 'database_cleaner'
require 'pry'

require File.expand_path('../../lib/bustle', __FILE__)
Dir[File.expand_path('../../specs/support/**/*.rb', __FILE__)].each {|f| require f}

BUSTLE_STORAGES = [
  Bustle::Storage::ActiveRecord
]

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    module Bustle::Dummy
      class User < ActiveRecord::Base; end
      class Post < ActiveRecord::Base; end
      class Comment < ActiveRecord::Base; end
    end

    Bustle.config do |c|
      c.storage = Bustle::Storage::ActiveRecord
    end
  end

  DatabaseCleaner.strategy = :truncation
  config.before do
    DatabaseCleaner.clean
  end
end
