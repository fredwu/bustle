module Bustle
  class Activity < "#{Bustle.storage}::Activity".constantize
    include Concern::Destroyable
  end
end
