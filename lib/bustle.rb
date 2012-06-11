require 'active_support/dependencies'

require "bustle/version"

module Bustle
  mattr_accessor :storage

  module Storage
    autoload :ActiveRecord, 'bustle/storage/active_record'
  end

  def self.config
    yield self

    require 'bustle/models/activity'
    require 'bustle/models/publisher'
    require 'bustle/models/subscriber'
    require 'bustle/models/subscription'
  end
end
