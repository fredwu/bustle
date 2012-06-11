module Bustle
  class Subscription < "#{Bustle.storage}::Subscription".constantize
    include Concern::Destroyable
  end
end
