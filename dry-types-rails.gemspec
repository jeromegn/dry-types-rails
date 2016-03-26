# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dry/types/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "dry-types-rails"
  spec.version       = Dry::Types::Rails::VERSION
  spec.authors       = ["Jerome Gravel-Niquet"]
  spec.email         = ["jeromegn@gmail.com"]

  spec.summary       = "Simplifies dry-types usage with Rails."
  spec.description   = "Simplifies dry-types usage with Rails."
  spec.homepage      = "https://github.com/jeromegn/dry-types-rails"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metatypes)
  #   spec.metatypes['allowed_push_host'] = "https://rubygems.org"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'combustion', '~> 0.5.4'
  spec.add_development_dependency 'rspec-rails', '~> 3.4.0'

  spec.add_runtime_dependency 'rails', '>= 3'
  spec.add_runtime_dependency 'dry-types'
end
