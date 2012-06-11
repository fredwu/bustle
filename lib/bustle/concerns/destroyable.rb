module Bustle::Concern
  module Destroyable
    extend ActiveSupport::Concern

    included do
      def destroy
        case self.class.superclass.superclass.name
        when 'ActiveRecord::Base'
          super
        end
      end
    end
  end
end
