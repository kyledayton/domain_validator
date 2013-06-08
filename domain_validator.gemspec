# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'domain_validator/version'

Gem::Specification.new do |spec|
  spec.name          = "domain_validator"
  spec.version       = DomainValidator::VERSION
  spec.authors       = ["Kyle Dayton"]
  spec.email         = ["kyle@graphicflash.com"]
  spec.description   = %q{Adds ActiveModel validation for domain format.}
  spec.summary       = %q{Adds ActiveModel validation for domain format.}
  spec.homepage      = "http://github.com/kdayton-/domain_validator"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
