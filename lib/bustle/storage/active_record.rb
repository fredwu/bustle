require 'active_record'
require 'bustle/storage/active_record/activity'
require 'bustle/storage/active_record/publisher'
require 'bustle/storage/active_record/subscriber'
require 'bustle/storage/active_record/subscription'

module Bustle::Storage::ActiveRecord
  class Base < ::ActiveRecord::Base
    self.table_name_prefix = 'bustle_'
  end
end