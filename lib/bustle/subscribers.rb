module Bustle
  class Subscribers
    def self.add(resource)
      Subscriber.to_adapter.create!(
        :resource_class => resource.class.name,
        :resource_id    => resource.id
      )
    end
  end
end
