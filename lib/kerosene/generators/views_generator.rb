# frozen_string_literal: true

require_relative 'base'

module Kerosene
  class ViewsGenerator < Generators::Base
    def create_application_layout
      template  'application.html.erb.erb',
                'app/views/layouts/application.html.erb',
                force: true
    end
  end
end
