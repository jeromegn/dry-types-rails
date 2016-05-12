module Dry
  module Types
    module Rails
      module TypesRegistration
        REGISTERED_TYPES = Concurrent::Array.new

        def register_class(klass, meth = :new)
          super.tap do
            # Check to see if we need to remove the registered type
            autoloaded = ActiveSupport::Dependencies.will_unload?(klass)
            # ActiveSupport::Dependencies.will_unload?(klass) won't return true yet
            #   if it's the first time a constant is being autoloaded
            #   so we have to see if we're in the middle of loading a missing constants
            autoloaded |= caller(4).any? { |line| line =~ /\:in.*?load_missing_constant/ }

            REGISTERED_TYPES << klass if autoloaded
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
          TypesRegistration::REGISTERED_TYPES.each do |type|
            type = Dry::Types.identifier(type)
            Dry::Types.container._container.delete(type)
            Dry::Types.type_map.delete(type)
          end
        end
      end
    end
  end
end
