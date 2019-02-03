# frozen_string_literal: true

module Kerosene
  class AppGenerator < Rails::Generators::AppGenerator
    hide!

    class_option  :github, type: :string, default: nil,
                  desc: 'Create Github repository and add remote origin pointed to repo'

    class_option :skip_test, type: :boolean, default: true, desc: 'Skip Test Unit'

    class_option :skip_turbolinks, type: :boolean, default: true, desc: 'Skip turbolinks gem'
  end
end
