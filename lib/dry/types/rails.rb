require "dry/types/rails/version"

require 'dry/types'
require 'dry/types/rails/registry'
require 'dry/types/rails/railtie'

module Dry
  module Types
    container.config.registry = ::Dry::Types::Rails::Registry.new
  end
end
