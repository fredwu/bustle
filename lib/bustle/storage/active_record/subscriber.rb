module Bustle::Storage::ActiveRecord
  class Subscriber < ActiveRecord::Base
    self.table_name = 'bustle_subscribers'
  end
end