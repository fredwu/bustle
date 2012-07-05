module Bustle::Concern
  module PublisherResource
    extend ActiveSupport::Concern

    def publisher_resource
      publisher = Bustle::Publisher.to_adapter.get!(self.publisher_id)
      publisher.resource_class.constantize.to_adapter.get!(publisher.resource_id)
    end
  end
end
