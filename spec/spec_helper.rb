$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'domain_validator'
require 'rspec'
require 'active_model'

class Model
  include ActiveModel::Validations

  def initialize(attrs = {})
    @attributes = attrs
  end

  def read_attribute_for_validation(key)
    @attributes[key]
  end
end

RSpec.configure do |c|
  require 'support/domain_helpers'
  c.extend DomainHelpers
end