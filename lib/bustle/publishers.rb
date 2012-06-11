module Bustle
  class Publishers
    def self.add(resource)
      Publisher.to_adapter.create!(
        :resource_class => resource.class.name,
        :resource_id    => resource.id
      )
    end
  end
end
