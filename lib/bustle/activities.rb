module Bustle
  class Activities
    RESOURCE_NAME = 'Bustle::Activity'

    include Concern::Filterable
    include Concern::ByPublisher

    class << self
      def add(publisher, action, activity_resource)
        Activity.to_adapter.create!(
          :resource_class => activity_resource.class.name,
          :resource_id    => activity_resource.id,
          :action         => action,
          :publisher_id   => publisher.id
        )
      end

      def for(subscriber, conditions = {})
        publisher_ids = Subscriptions.for(subscriber).map(&:publisher_id)

        filter({ :publisher_id => publisher_ids }.merge(conditions))
      end
    end
  end
end
