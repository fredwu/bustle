module Bustle
  class Subscriber < "#{Bustle.storage}::Subscriber".constantize
    def activities(conditions = {})
      Activities.for(self, conditions)
    end
  end
end
