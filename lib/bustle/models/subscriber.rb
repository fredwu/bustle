module Bustle
  class Subscriber < "#{Bustle.storage}::Subscriber".constantize
    include Concern::Destroyable
  end
end
