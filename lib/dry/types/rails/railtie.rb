module Dry
  module Types
    module Rails
      module TypesRegistration
        REGISTERED_TYPES = Concurrent::Array.new

        def register(name, type = nil, &block)
          return super unless type
          return if TypesRegistration::REGISTERED_TYPES.include?(name)

          super.tap do
            # Check to see if we need to remove the registered type
            autoloaded = ActiveSupport::Dependencies.will_unload?(type)
            # ActiveSupport::Dependencies.will_unload?(klass) won't return true yet
            #   if it's the first time a constant is being autoloaded
            #   so we have to see if we're in the middle of loading a missing constants
            autoloaded |= caller.any? { |line| line =~ /\:in.*?new_constants_in/ }

            TypesRegistration::REGISTERED_TYPES << name if autoloaded
          end
        end
      end

      Dry::Types.module_eval do
        class << self
          prepend(TypesRegistration)
        end
      end

      class Railtie < ::Rails::Railtie
        config.to_prepare do
          types = TypesRegistration::REGISTERED_TYPES.dup
          types.each do |type|
            TypesRegistration::REGISTERED_TYPES.delete(type)
            type = Dry::Types.identifier(type)
            Dry::Types.container._container.delete(type)
            Dry::Types.type_map.delete(type)
          end
        end
      end
    end
  end
end
