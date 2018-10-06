# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shift_ciphers/version'

Gem::Specification.new do |s|
  s.name          = "shift_ciphers"
  s.version       = ShiftCiphers::VERSION
  s.authors       = ["Tomasz Więch"]
  s.email         = ["tewu.dev@gmail.com"]

  s.summary       = "Implementation of Caesar and Vigenere ciphers"
  s.description   = "Implementation of Caesar and Vigenere ciphers"
  s.homepage      = "https://github.com/TeWu/shift-ciphers"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(doc|test|spec|features|bin)/|Rakefile|Gemfile*|CHANGELOG}) || f.start_with?('.') }
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 2.1.0"

  s.add_development_dependency "bundler", "~> 1.16"
  s.add_development_dependency "pry", "~> 0.11"
  s.add_development_dependency "rspec", "~> 3.8"
end