require "active_model"
require "active_model/validator"

module DomainValidator
  class Validator < ActiveModel::EachValidator
    
    RE_DOMAIN = %r(^(?=.{1,255}$)[0-9A-Za-z](?:(?:[0-9A-Za-z]|-){0,61}[0-9A-Za-z])?(?:\.[0-9A-Za-z](?:(?:[0-9A-Za-z]|-){0,61}[0-9A-Za-z])?)+$)

    def validate_each(record, attr_name, value)
      validate_domain_format(record, attr_name, value)
      # Only waste time with DNS check if record is invalid?
      validate_domain_dns(record, attr_name, value) if record.errors.empty? && options[:verify_dns]
    end

    def validate_domain_format(record, attr_name, value)
      valid_domain = is_valid_domain?(value)
      record.errors.add(attr_name, options[:message] || "is invalid") unless valid_domain
    end

    def validate_domain_dns(record, attr_name, value)
      valid_domain = has_dns_record?(value)
      record.errors.add(attr_name, verify_dns_message || "does not have a DNS record") unless valid_domain
    end

    def is_valid_domain?(domain)
      domain =~ RE_DOMAIN
    end

    def has_dns_record?(domain)
      options[:verify_dns] ? DnsCheck.has_record?(domain) : true
    end

    def verify_dns_message
      verify_dns = options[:verify_dns]
      if verify_dns.is_a? Hash
        verify_dns[:message] || options[:message]
      end
    end

  end
end

ActiveModel::Validations::DomainValidator = DomainValidator::Validator
