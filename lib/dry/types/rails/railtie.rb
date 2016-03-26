module Dry
  module Types
    module Rails
      class Railtie < ::Rails::Railtie
        config.to_prepare do
          if Dry::Types.instance_variable_defined? :@container
            Dry::Types.remove_instance_variable :@container
          end
        end
      end
    end
  end
end