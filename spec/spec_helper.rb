require 'rubygems'
require 'bundler/setup'

require 'combustion'

Combustion.initialize! :action_controller, :action_view, :sprockets

require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end