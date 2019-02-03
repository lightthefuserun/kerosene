# frozen_string_literal: true

lib = File.expand_path('../lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kerosene/version'

Gem::Specification.new do |spec|
  spec.required_ruby_version = ">= #{Kerosene::RUBY_VERSION}"

  spec.name          = 'kerosene'
  spec.version       = Kerosene::VERSION
  spec.authors       = ['Light the Fuse and Run']
  spec.email         = ['wecan@lightthefusea.run']

  spec.description = <<-HERE
  Kerosene is a base Rails project used to quicky ignite and get a working app.
  HERE

  spec.summary       = "Generate a Rails app using LTR's template."
  spec.homepage      = 'http://github.com/lightthefuserun/kerosene/blob/master/Rakefile'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __dir__)) do
    `git ls-files -z`.split('\x0').reject { |d| d.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.63'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.30'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
