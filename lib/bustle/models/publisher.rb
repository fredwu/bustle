module Bustle
  class Publisher < "#{Bustle.storage}::Publisher".constantize
    def publish(data = {})
      Activities.add(self, data)
    end

    def activities(conditions = {})
      Activities.by(self, conditions)
    end
  end
end
