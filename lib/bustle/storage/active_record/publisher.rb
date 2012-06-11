module Bustle::Storage::ActiveRecord
  class Publisher < ::ActiveRecord::Base
    self.table_name = 'bustle_publishers'
  end
end