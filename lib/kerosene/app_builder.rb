# frozen_string_literal: true

module Kerosene
  class AppBuilder < Rails::AppBuilder
    include Kerosene::Actions

    def readme
      template 'README.md.erb', 'README.md'
    end

    def gemfile
      template 'Gemfile.erb', 'Gemfile'
    end

    def replace_gemfile(path)
      template 'Gemfile.erb', 'Gemfile', force: true do |content|
        if path
          content.gsub(%r{gem .kerosene.}) { |s| %{#{s}, path: "#{path}"} }
        else
          content
        end
      end
    end

    def ruby_version
      create_file '.ruby-version', "#{Kerosene::RUBY_VERSION}\n"
    end

    def provide_setup_script
      template 'bin_setup', 'bin/setup', force: true
      run 'chmod a+x bin/setup'
    end

    def setup_spring
      bundle_command 'exec spring binstub --all'
    end
  end
end
