# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'arroyo/version'

Gem::Specification.new do |spec|
  spec.name          = "arroyo"
  spec.version       = Arroyo::VERSION
  spec.authors       = ["Marshall Mickelson"]
  spec.email         = ["me@earthcolonist.com"]

  spec.summary       = %q{Basic Ruby Helpers}
  spec.description   = %q{Basic Ruby Helpers}
  spec.homepage      = "https://github.com/marshallmick007/arroyo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.2.1"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "awesome_print", "~> 1.7.0"
end
