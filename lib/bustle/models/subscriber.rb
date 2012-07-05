module Bustle
  class Subscriber < "#{Bustle.storage}::Subscriber".constantize
    include Concern::TargetResource

    def activities(conditions = {})
      Activities.for(self, conditions)
    end
  end
end
