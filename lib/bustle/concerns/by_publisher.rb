module Bustle::Concern
  module ByPublisher
    extend ActiveSupport::Concern

    module ClassMethods
      def by(publisher)
        filter(:publisher_id  => publisher.id)
      end
    end
  end
end
