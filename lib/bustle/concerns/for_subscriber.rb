module Bustle::Concern
  module ForSubscriber
    extend ActiveSupport::Concern

    module ClassMethods
      def for(subscriber, conditions = {})
        filter({ :subscriber_id => subscriber.id }.merge(conditions))
      end
    end
  end
end
