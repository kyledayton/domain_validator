require 'spec_helper'

class User < Model
  validates :domain, :domain => true
end

class UserAllowsNil < Model
  validates :domain, :domain => {:allow_nil => true}
end

class UserAllowsNilFalse < Model
  validates :domain, :domain => {:allow_nil => false}
end

class UserAllowsBlank < Model
  validates :domain, :domain => {:allow_blank => true}
end

class UserAllowsBlankFalse < Model
  validates :domain, :domain => {:allow_blank => false}
end

class UserWithMessage < Model
  validates :domain, :domain => {:message => "isn't quite right"}
end

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
      subject { User.new :domain => "domain.withinvalidtld" }
      before { subject.valid? }

      it "should add the default message" do
        subject.errors[:domain].should include "is invalid"
      end
    end

    context "when the :message option is defined" do
      subject { UserWithMessage.new :domain => "domain.withinvalidtld" }
      before { subject.valid? }

      it "should add the customized message" do
        subject.errors[:domain].should include "isn't quite right"
      end
    end
  end

end