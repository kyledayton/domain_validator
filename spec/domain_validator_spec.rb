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

end