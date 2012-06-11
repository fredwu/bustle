module Bustle::Storage::ActiveRecord
  class Subscription < ActiveRecord::Base
    self.table_name = 'bustle_subscriptions'
  end
end