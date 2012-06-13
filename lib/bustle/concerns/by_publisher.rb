module Bustle::Concern
  module ByPublisher
    extend ActiveSupport::Concern

    module ClassMethods
      def by(publisher, conditions = {})
        filter({ :publisher_id => publisher.id }.merge(conditions))
      end
    end
  end
end
