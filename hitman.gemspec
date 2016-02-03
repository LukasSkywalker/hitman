# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hitman/version'

Gem::Specification.new do |spec|
  spec.name          = "hitman"
  spec.version       = Hitman::VERSION
  spec.authors       = ["Lukas_Skywalker"]
  spec.email         = ["lukas.diener@hotmail.com"]

  spec.summary       = "API fuzzing for professionals"
  spec.description   = "Fuzzes all your API endpoints with the toughest input until it breaks."
  spec.homepage      = "https://bitbucket.org/Zeilenwerk/hitman"
  spec.license       = "GPLv3"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
