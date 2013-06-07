# DomainValidator

ActiveModel vaidations for domains

## Installation

Add this line to your application's Gemfile:

    gem 'domain_validator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install domain_validator

## Usage

Add a 'domain' validation to your ActiveModel enabled class

```ruby
class User < ActiveRecord::Base
  validates :domain, :domain => true
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add some specs (so I don't accidentally break your functionality in future versions)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
