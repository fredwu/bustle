module Bustle
  class Publisher < "#{Bustle.storage}::Publisher".constantize
    include Concern::Destroyable

    def publish(action, activity_resource)
      Activities.add self, action, activity_resource
    end
  end
end
