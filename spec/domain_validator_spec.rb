require 'spec_helper'
require 'support/models'

describe DomainValidator do
  context "with valid domain" do
    valid_domains.each do |domain|
      user = User.new(:domain => domain)

      it "#{domain} should be valid" do
        expect(user).to be_valid
      end
    end
  end

  context "with invalid domain" do
    invalid_domains.each do |domain|
      user = User.new(:domain => domain)

      it "#{domain} should be invalid" do
        expect(user).to_not be_valid
      end
    end
  end

  describe "nil domain" do

    it "should not be valid when :allow_nil option is missing" do
      user = User.new(:domain => nil)
      expect(user).to_not be_valid
    end

    it "should be valid when :allow_nil option is true" do
      user = UserAllowsNil.new(:domain => nil)
      expect(user).to be_valid
    end

    it "should not be valid when :allow_nil option is false" do
      user = UserAllowsNilFalse.new(:domain => nil)
      expect(user).to_not be_valid
    end
  end

  describe "blank domain" do
    it "should not be valid when :allow_blank option is missing" do
      user = User.new(:domain => "   ")
      expect(user).to_not be_valid
    end

    it "should be valid when :allow_blank option is true" do
      user = UserAllowsBlank.new(:domain => "   ")
      expect(user).to be_valid
    end

    it "should not be valid when :allow_blank option is false" do
      user = UserAllowsBlankFalse.new(:domain => "   ")
      expect(user).to_not be_valid
    end
  end

  describe "error messages" do
    context "when the :message option is not defined" do
      subject { User.new :domain => "notadomain" }
      before { subject.valid? }

      it "should add the default message" do
        expect(subject.errors[:domain]).to include "is invalid"
      end
    end

    context "when the :message option is defined" do
      subject { UserWithMessage.new :domain => "notadomain" }
      before { subject.valid? }

      it "should add the customized message" do
        expect(subject.errors[:domain]).to include "isn't quite right"
      end
    end

    context "when :verify_dns has a :message option" do
      subject { UserVerifyDNSMessage.new :domain => "a.com" }
      before { subject.valid? }

      it "should add the customized message" do
        expect(subject.errors[:domain]).to include "failed DNS check"
      end
    end

    context "when :verify_dns does not have a :message option" do
      subject { UserVerifyDNS.new :domain => "a.com" }
      before { subject.valid? }

      it "should add the default message" do
        expect(subject.errors[:domain]).to include "does not have a DNS record"
      end
    end
  end

  describe "DNS check" do
    describe "an invalid domain" do
      it "should not perform a DNS check" do
        expect_any_instance_of(DomainValidator::DnsCheck).to_not receive(:has_record?)
        user = UserVerifyDNS.new(:domain => "notadomain")
        expect(user).to_not be_valid
      end
    end

    describe "a domain with a DNS record" do
      it "should be valid when :verify_dns is true" do
        user = UserVerifyDNS.new(:domain => "example.com")
        expect(user).to be_valid
      end

      it "should be valid when :verify_dns is false" do
        user = UserVerifyDNSFalse.new(:domain => "example.com")
        expect(user).to be_valid
      end

      it "should be valid when :verify_dns is undefined" do
        user = User.new(:domain => "example.com")
        expect(user).to be_valid
      end
    end

    describe "a domain without a DNS record" do
      it "should not be valid when :verify_dns is true" do
        user = UserVerifyDNS.new(:domain => "a.com")
        expect(user).to_not be_valid
      end

      it "should be valid when :verify_dns is false" do
        user = UserVerifyDNSFalse.new(:domain => "a.com")
        expect(user).to be_valid
      end

      it "should be valid when :verify_dns is undefined" do
        user = User.new(:domain => "a.com")
        expect(user).to be_valid
      end
    end
  end

end