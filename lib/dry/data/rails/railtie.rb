module Dry
  module Data
    module Rails
      class Railtie < ::Rails::Railtie
        config.to_prepare do
          Dry::Data.remove_instance_variable :@container
        end
      end
    end
  end
end