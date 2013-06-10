require 'resolv'

module DomainValidator
  class DnsCheck

    def self.has_record?(domain)
      begin
        Resolv::DNS.new.getaddress domain
        return true
      rescue Resolv::ResolvError => e
        return false
      end
    end

  end
end