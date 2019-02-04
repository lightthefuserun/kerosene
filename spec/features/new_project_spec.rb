require 'spec_helper'

RSpec.describe "Creates a new project with default configuration" do
  before(:all) do
    drop_dummy_database
    remove_project_directory
    run_kerosene
    setup_app_dependencies
  end

  it "uses custom Gemfile" do
    gemfile_file = IO.read("#{project_path}/Gemfile")
    expect(gemfile_file).to match(
      /^ruby '#{Kerosene::RUBY_VERSION}'$/,
    )
    expect(gemfile_file).to match(
      /^gem 'autoprefixer-rails'$/,
    )
    expect(gemfile_file).to match(
      /^gem 'sidekiq'$/,
    )
    expect(gemfile_file).to match(
      /^gem 'rails', '#{Kerosene::RAILS_VERSION}'$/,
    )
  end

  it "uses custom Application layout" do
    application_layout = IO.read("#{project_path}/app/views/layouts/application.html.erb")
    expect(application_layout).to match(
      /^<body class="<%= controller_name %> <%= action_name %>">$/,
    )
  end

  it "runs webpacker installation" do
    webpacker_yml = "#{project_path}/config/webpacker.yml"
    expect(webpacker_yml).to be_an_existing_file
  end

  it "adds bin/setup file" do
    expect(File).to exist("#{project_path}/bin/setup")
  end

  it "makes bin/setup executable" do
    pending('fix test')
    expect("bin/setup").to be_executable
  end

  it "creates .ruby-version from Kerosene .ruby-version" do
    ruby_version_file = IO.read("#{project_path}/.ruby-version")

    expect(ruby_version_file).to eq "#{RUBY_VERSION}\n"
  end

  it "doesn't generate test directory" do
    expect(File).not_to exist("#{project_path}/test")
  end

  it "adds sassc-rails" do
    gemfile = read_project_file("Gemfile")

    expect(gemfile).to match(/sassc-rails/)
  end

  def development_config
    @_development_config ||=
      read_project_file %w(config environments development.rb)
  end

  def test_config
    @_test_config ||= read_project_file %w(config environments test.rb)
  end

  def production_config
    @_production_config ||=
      read_project_file %w(config environments production.rb)
  end

  def read_project_file(path)
    IO.read(File.join(project_path, *path))
  end
end
