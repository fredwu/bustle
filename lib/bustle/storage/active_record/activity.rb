module Bustle::Storage::ActiveRecord
  class Activity < ::ActiveRecord::Base
    self.table_name = 'bustle_activities'
  end
end