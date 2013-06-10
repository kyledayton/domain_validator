# DomainValidator

[![Build Status](https://travis-ci.org/kdayton-/domain_validator.png?branch=master)](https://travis-ci.org/kdayton-/domain_validator)
[![Code Climate](https://codeclimate.com/github/kdayton-/domain_validator.png)](https://codeclimate.com/github/kdayton-/domain_validator)

Adds a DomainValidator to ActiveModel, allowing for easy validation of FQDNs


## Installation

Add this line to your application's Gemfile:

    gem 'domain_validator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install domain_validator

## Usage

Add a domain validation to your ActiveModel enabled class

```ruby
class User < ActiveRecord::Base
  attr_accessible :domain
  validates :domain, :domain => true
end
```

## Examples

```ruby
user = User.new :domain => 'mydomain.com'
user.valid? # => true

user.domain = 'invalid*characters.com'
user.valid? # => false
```

## Compatibility

DomainValidator is tested against:

MRI 1.8.7, 1.9.3, 2.0.0
JRuby 1.8, 1.9
Rubinus 1.8

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add some specs (so I don't accidentally break your functionality in future versions)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
