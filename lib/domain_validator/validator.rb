require 'active_model'
require 'active_model/validator'

module DomainValidator
  class Validator < ActiveModel::EachValidator
    
    RE_DOMAIN = %r(^(?=.{1,255}$)[0-9A-Za-z](?:(?:[0-9A-Za-z]|-){0,61}[0-9A-Za-z])?(?:\.[0-9A-Za-z](?:(?:[0-9A-Za-z]|-){0,61}[0-9A-Za-z])?)+$)

    def validate_each(record, attr_name, value)
      valid_domain = is_valid_domain?(value)
      record.errors.add(attr_name, options[:message] || "is invalid") and return unless valid_domain
    end

    def is_valid_domain?(domain)
      domain =~ RE_DOMAIN
    end

  end
end

ActiveModel::Validations::DomainValidator = DomainValidator::Validator
