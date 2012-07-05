module Bustle
  class Activity < "#{Bustle.storage}::Activity".constantize
    include Concern::TargetResource
    include Concern::PublisherResource
  end
end
