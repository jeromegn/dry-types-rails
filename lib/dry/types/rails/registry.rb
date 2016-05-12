module Dry
  module Types
    module Rails
      class Registry < ::Dry::Container::Registry
        def call(container, key, item, options)
          key = key.to_s.dup.freeze
          @_mutex.synchronize do
            container.delete(key) if container.key?(key)
            container[key] = ::Dry::Container::Item.new(item, options)
          end
        end
      end
    end
  end
end
