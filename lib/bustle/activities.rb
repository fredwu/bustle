module Bustle
  class Activities
    RESOURCE_NAME = 'Bustle::Activity'

    include Concern::Filterable
    include Concern::ByPublisher

    class << self
      def add(publisher, data = {})
        data = data.dup

        if resource = data.delete(:resource)
          data[:resource_class] = resource.class.name
          data[:resource_id]    = resource.id
        end

        Activity.to_adapter.create!(
          :resource_class => data[:resource_class],
          :resource_id    => data[:resource_id],
          :action         => data[:action],
          :data           => data[:data],
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
