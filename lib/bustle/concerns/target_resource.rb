module Bustle::Concern
  module TargetResource
    extend ActiveSupport::Concern

    def target_resource
      self.resource_class.constantize.to_adapter.get!(self.resource_id)
    end
  end
end
