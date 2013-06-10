require 'spec_helper'

module DomainValidator
  describe DnsCheck do
    describe '#has_record?' do

      context "given a domain without a DNS record" do
        it "should return false" do
          DnsCheck.has_record?("a.com").should be_false
        end
      end

      context "given a domain with a DNS record" do
        it "should return true" do
          DnsCheck.has_record?("example.com").should be_true
        end
      end

    end
  end
end