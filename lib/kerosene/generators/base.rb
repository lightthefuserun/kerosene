# frozen_string_literal: true

require 'rails/generators'
require_relative '../actions'

module Kerosene
  module Generators
    class Base < Rails::Generators::Base
      include Kerosene::Actions

      def self.default_source_root
        File.expand_path(File.join('..', '..', '..', 'templates'), __FILE__)
      end

      private

      def app_name
        Rails.app_class.parent_name.demodulize.underscore.dasherize
      end
    end
  end
end
