# frozen_string_literal: true

require 'rails/generators'
require 'rails/generators/rails/app/app_generator'

module Kerosene
  class AppGenerator < Rails::Generators::AppGenerator
    hide!

    class_option :database, type: :string, aliases: "-d", default: "postgresql",
      desc: "Configure for selected database (options: #{DATABASES.join("/")})"

    class_option  :github, type: :string, default: nil,
                  desc: 'Create Github repository and add remote origin pointed to repo'

    class_option  :version, type: :boolean, aliases: "-v", group: :kerosene,
                  desc: "Show Kerosene version number and quit"

    class_option :help, type: :boolean, aliases: '-h', group: :kerosene,
                  desc: "Show this help message and quit"

    class_option :skip_test, type: :boolean, default: true, desc: 'Skip Test Unit'

    class_option :skip_system_test,
                 type: :boolean, default: true, desc: "Skip system test files"

    class_option :skip_webpack_install, type: :boolean, default: false,
                                          desc: "Don't run Webpack install"

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

    def run_webpack
      if webpack_install?
        rails_command "webpacker:install"
        rails_command "webpacker:install:#{options[:webpack]}" if options[:webpack] && options[:webpack] != "webpack"
      end
    end

    protected

    def get_builder_class
      Kerosene::AppBuilder
    end

    private

    def webpack_install?
      !(options[:skip_javascript] || options[:skip_webpack_install])
    end
  end
end
