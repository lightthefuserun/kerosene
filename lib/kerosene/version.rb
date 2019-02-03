# frozen_string_literal: true

module Kerosene
  RAILS_VERSION = '~> 5.2.0'
  RUBY_VERSION =  IO
                  .read("#{File.dirname(__FILE__)}/../../.ruby-version")
                  .strip
  VERSION = '0.1.21'
end
