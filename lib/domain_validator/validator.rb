require 'active_model'
require 'active_model/validator'

require 'public_suffix'

module DomainValidator
  class Validator < ActiveModel::EachValidator
    
    def validate_each(record, attr_name, value)
      valid_domain = is_valid_domain?(value)
      record.errors.add(attr_name, options[:message] || "is invalid") and return unless valid_domain
    end

    def is_valid_domain?(domain)
      PublicSuffix.valid? domain
    end

  end
end

ActiveModel::Validations::DomainValidator = DomainValidator::Validator
