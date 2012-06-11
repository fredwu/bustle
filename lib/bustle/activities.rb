module Bustle
  class Activities
    def self.add(publisher, action, activity_resource)
      Activity.to_adapter.create!(
        :resource_class => activity_resource.class.name,
        :resource_id    => activity_resource.id,
        :action         => action,
        :publisher_id   => publisher.id
      )
    end
  end
end
