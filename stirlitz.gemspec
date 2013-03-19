# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stirlitz/version'

Gem::Specification.new do |spec|
  spec.name          = "stirlitz"
  spec.version       = Stirlitz::VERSION
  spec.authors       = ["Andrey Savchenko"]
  spec.email         = ["andrey@aejis.eu"]
  spec.description   = %q{Spy/Fake-object library}
  spec.summary       = %q{Spy/Fake-object library}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
