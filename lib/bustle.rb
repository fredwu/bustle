require 'active_support/dependencies'

require "bustle/version"

module Bustle
  mattr_accessor :intepreter
  mattr_accessor :storage

  def self.config
    yield self
  end
end
