# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kerosene/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = ">= #{Kerosene::RUBY_VERSION}"

  spec.name          = 'kerosene'
  spec.version       = Kerosene::VERSION
  spec.authors       = ['Light the Fuse and Run']
  spec.email         = ['wecan@lightthefusea.run']

  spec.description = <<-HERE
  Kerosene is a base Rails project used to quicky get a working app off the ground.
  It includes a custom gemfile. Use it to ignite your rails apps.
  HERE

  spec.summary       = "Generate a Rails app using LTF's template."
  spec.homepage      = 'https://github.com/lightthefuserun/kerosene'
  spec.license       = 'MIT'

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', Kerosene::RAILS_VERSION

  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'rubocop', '~> 0.63'
end
