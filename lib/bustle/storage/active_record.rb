require 'active_record'

module Bustle::Storage::ActiveRecord
  class Base < ::ActiveRecord::Base
  end
end

require 'bustle/storage/active_record/activity'
require 'bustle/storage/active_record/publisher'
require 'bustle/storage/active_record/subscriber'
require 'bustle/storage/active_record/subscription'
