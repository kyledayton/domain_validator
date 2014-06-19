# DomainValidator

[![Build Status](https://travis-ci.org/kyledayton/domain_validator.png?branch=master)](https://travis-ci.org/kyledayton/domain_validator)
[![Code Climate](https://codeclimate.com/github/kyledayton/domain_validator.png)](https://codeclimate.com/github/kyledayton/domain_validator)

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

DomainValidator can also perform a DNS check using ruby's built-in Resolv library

```ruby
class User < ActiveRecord::Base
  attr_accessible :domain
  validates :domain, :domain => {:verify_dns => true}

  # Also supports a custom message when failing DNS check
  # validates :domain, :domain => {:verify_dns => {:message => "DNS check failed"}}
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

MRI 1.9.3, 2.0, 2.1.1, 2.1.2
JRuby 1.9  
Rubinus 2.1.1

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add some specs (so I don't accidentally break your functionality in future versions)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
