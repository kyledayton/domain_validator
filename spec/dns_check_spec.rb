require 'spec_helper'

# I hope no one registers this
NOT_A_REAL_DOMAIN = "zjnajkndsjkangunausgnasngiuansiugnaiusngansjkgnaskjnaksjdn.com"

module DomainValidator
  describe DnsCheck do
    describe '#has_record?' do

      context "given a domain without a DNS record" do
        it "should return false" do
          expect( DnsCheck.has_record?(NOT_A_REAL_DOMAIN) ).to eq false
        end
      end

      context "given a domain with a DNS record" do
        it "should return true" do
          expect( DnsCheck.has_record?("example.com") ).to eq true
        end
      end

    end
  end
end