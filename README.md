# Dry::Types::Rails

Really simple gem that will help you work with the [`dry-types`](https://github.com/dryrb/dry-types) gem in development.

## Raison d'être

Rails reloads code quite often in development, this broke the usage of `Dry::Data` since it would register the same types multiple times and raise exceptions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dry-types-rails'
```

## Usage

Nothing to do, this is using `Rails::Railtie`, which means it gets loaded automatically.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jeromegn/dry-types-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

