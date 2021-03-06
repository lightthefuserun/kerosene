# frozen_string_literal: true

module KeroseneTestHelpers
  APP_NAME = "dummy_app"

  def remove_project_directory
    FileUtils.rm_rf(project_path)
  end

  def create_tmp_directory
    FileUtils.mkdir_p(tmp_path)
  end

  def run_kerosene(arguments = nil)
    arguments = "--path=#{root_path} #{arguments}"
    run_in_tmp do
      debug `#{kerosene_bin} #{APP_NAME} #{arguments}`
    end
  end

  def with_app
    drop_dummy_database
    remove_project_directory
    rails_new
    setup_app_dependencies

    yield
  end

  def rails_new
    run_in_tmp do
      debug `#{system_rails_bin} new #{APP_NAME}`

      Dir.chdir(APP_NAME) do
        File.open("Gemfile", "a") do |file|
          file.puts %{gem "kerosene", path: #{root_path.inspect}}
        end
      end
    end
  end

  def generate(generator)
    run_in_project do
      debug `bin/spring stop`
      debug `#{project_rails_bin} generate #{generator}`
    end
  end

  def setup_app_dependencies
    run_in_project do
      debug `bundle check || bundle install`
    end
  rescue Errno::ENOENT
    # The project_path might not exist, in which case we can skip this.
  end

  def drop_dummy_database
    run_in_project do
      debug `#{project_rails_bin} db:drop 2>&1`
    end
  rescue Errno::ENOENT
    # The project_path might not exist, in which case we can skip this.
  end

  def project_path
    @project_path ||= Pathname.new("#{tmp_path}/#{APP_NAME}")
  end

  private

  def tmp_path
    @tmp_path ||= Pathname.new("#{root_path}/tmp")
  end

  def kerosene_bin
    File.join(root_path, 'bin', 'kerosene')
  end

  def system_rails_bin
    'rails'
  end

  def project_rails_bin
    'bin/rails'
  end

  def root_path
    File.expand_path('../../../', __FILE__)
  end

  def run_in_tmp
    Dir.chdir(tmp_path) do
      Bundler.with_clean_env do
        yield
      end
    end
  end

  def run_in_project
    Dir.chdir(project_path) do
      Bundler.with_clean_env do
        yield
      end
    end
  end

  def debug(output)
    if ENV["DEBUG"]
      warn output
    end

    output
  end
end
