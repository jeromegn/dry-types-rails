require 'rubygems'
require 'bundler/setup'

require 'combustion'
require 'active_support/dependencies'

Combustion.initialize! :action_controller, :action_view, :sprockets do
  config.eager_load = false
  config.cache_classes = false

  ActiveSupport::Dependencies.autoload_paths += Dir["#{config.root}/autoload-lib"]
end

require_relative "internal/lib/types"
require_relative "internal/lib/custom_types"
require_relative "internal/lib/schema_struct"

require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
