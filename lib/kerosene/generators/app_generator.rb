# frozen_string_literal: true

require 'rails/generators'
require 'rails/generators/rails/app/app_generator'

module Kerosene
  class AppGenerator < Rails::Generators::AppGenerator
    hide!

    class_option  :github, type: :string, default: nil,
                  desc: 'Create Github repository and add remote origin pointed to repo'

    class_option :skip_test, type: :boolean, default: true, desc: 'Skip Test Unit'

    class_option :skip_turbolinks, type: :boolean, default: true, desc: 'Skip turbolinks gem'

    def finish_template
      invoke :kerosene_customization
      super
    end

    def kerosene_customization
      invoke :customize_gemfile
      invoke :setup_development_environment
      invoke :setup_spring
      invoke :outro
    end

    def customize_gemfile
      build :replace_gemfile, options[:path]
      bundle_command 'install'
    end

    def setup_development_environment
      say 'Setting up the development environment'
      build :provide_setup_script
    end

    def setup_spring
      say 'Springifying binstubs'
      build :setup_spring
    end

    def outro
      say 'Congratulations! You\'ve just ignited rails.'
    end

    protected

    def get_builder_class
      Kerosene::AppBuilder
    end
  end
end
