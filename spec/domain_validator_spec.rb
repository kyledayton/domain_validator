require 'spec_helper'
require 'support/models'

describe DomainValidator do
  context "with valid domain" do
    valid_domains.each do |domain|
      it "#{domain} should be valid" do
        User.new(:domain => domain).should be_valid
      end
    end
  end

  context "with invalid domain" do
    invalid_domains.each do |domain|
      it "#{domain} should be invalid" do
        User.new(:domain => domain).should_not be_valid
      end
    end
  end

  describe "nil domain" do
    it "should not be valid when :allow_nil option is missing" do
      User.new(:domain => nil).should_not be_valid
    end

    it "should be valid when :allow_nil option is true" do
      UserAllowsNil.new(:domain => nil).should be_valid
    end

    it "should not be valid when :allow_nil option is false" do
      UserAllowsNilFalse.new(:domain => nil).should_not be_valid
    end
  end

  describe "blank domain" do
    it "should not be valid when :allow_blank option is missing" do
      User.new(:domain => "   ").should_not be_valid
    end

    it "should be valid when :allow_blank option is true" do
      UserAllowsBlank.new(:domain => "   ").should be_valid
    end

    it "should not be valid when :allow_blank option is false" do
      UserAllowsBlankFalse.new(:domain => "   ").should_not be_valid
    end
  end

  describe "error messages" do
    context "when the :message option is not defined" do
      subject { User.new :domain => "notadomain" }
      before { subject.valid? }

      it "should add the default message" do
        subject.errors[:domain].should include "is invalid"
      end
    end

    context "when the :message option is defined" do
      subject { UserWithMessage.new :domain => "notadomain" }
      before { subject.valid? }

      it "should add the customized message" do
        subject.errors[:domain].should include "isn't quite right"
      end
    end

    context "when :verify_dns has a :message option" do
      subject { UserVerifyDNSMessage.new :domain => "a.com" }
      before { subject.valid? }

      it "should add the customized message" do
        subject.errors[:domain].should include "failed DNS check"
      end
    end

    context "when :verify_dns does not have a :message option" do
      subject { UserVerifyDNS.new :domain => "a.com" }
      before { subject.valid? }

      it "should add the default message" do
        subject.errors[:domain].should include "does not have a DNS record"
      end
    end
  end

  describe "DNS check" do
    describe "an invalid domain" do
      it "should not perform a DNS check" do
        DomainValidator::DnsCheck.any_instance.should_not_receive(:has_record?)
        UserVerifyDNS.new(:domain => "notadomain").should_not be_valid
      end
    end

    describe "a domain with a DNS record" do
      it "should be valid when :verify_dns is true" do
        UserVerifyDNS.new(:domain => "example.com").should be_valid
      end

      it "should be valid when :verify_dns is false" do
        UserVerifyDNSFalse.new(:domain => "example.com").should be_valid
      end

      it "should be valid when :verify_dns is undefined" do
        User.new(:domain => "example.com").should be_valid
      end
    end

    describe "a domain without a DNS record" do
      it "should not be valid when :verify_dns is true" do
        UserVerifyDNS.new(:domain => "a.com").should_not be_valid
      end

      it "should be valid when :verify_dns is false" do
        UserVerifyDNSFalse.new(:domain => "a.com").should be_valid
      end

      it "should be valid when :verify_dns is undefined" do
        User.new(:domain => "a.com").should be_valid
      end
    end
  end

end