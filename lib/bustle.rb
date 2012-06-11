require 'active_support/dependencies'

require "bustle/version"

module Bustle
  mattr_accessor :storage

  module Storage
    autoload :ActiveRecord, 'bustle/storage/active_record'
  end

  def self.config
    yield self

    require 'bustle/activity'
    require 'bustle/publisher'
    require 'bustle/subscriber'
    require 'bustle/subscription'
  end
end
