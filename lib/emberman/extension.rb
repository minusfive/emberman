require 'middleman-core'
require 'middleman/rack'
module Middleman
  class EmbermanExtension < Extension
    option :app_name, :emberman, 'Name of your Ember app'

    def initialize(app, options_hash={}, &block)
      super

      # Add ember directory to list of ignored files
      app.config[:file_watcher_ignore] += [/^ember(\/|$)/]
      app.configure :development do
        sitemap.invalidate_resources_not_ignored_cache!
      end
      app.configure :build do
        sitemap.invalidate_resources_not_ignored_cache!
      end

      # Only initialize Ember app/server on development environment
      return if app.environment != :development

      # Initialize ember app/server
      emberman = self
      app.ready do
        if emberman.ember_dir_exists?
          if emberman.ember_cli_app_initialized?
            emberman.start_ember_server
          else
            emberman.initialize_ember_cli_app
          end
        else
          emberman.generate_ember_cli_app
        end
      end
    end

    def start_ember_server
      app.logger.info "\n\r== Emberman: Starting ember-cli server"
      in_ember_dir do
        system 'ember s --proxy http://localhost:4567 &', err: :out
      end
    end

    def initialize_ember_cli_app
      app_name = options.app_name.to_s.parameterize
      app.logger.info "== Emberman: Initializing ember-cli app \"#{app_name}\" in ./ember directory"
      Dir.chdir(File.join(app.root,'ember')) do
        system "ember init #{app_name}", err: :out
      end
      start_ember_server
    end

    def generate_ember_cli_app
      app_name = options.app_name.to_s.parameterize
      app.logger.info "== Emberman: Generating ember-cli app \"#{app_name}\" in ./ember directory"
      Dir.chdir(app.root) do
        system "ember new #{app_name} --skip-git", err: :out
        if File.directory?(File.join(app.root, app_name))
          FileUtils.mv app_name, 'ember'
        end
        start_ember_server
      end
    end

    def ember_dir_exists?
      File.directory? File.join(app.root, 'ember')
    end


    def ember_cli_app_initialized?
      dirs  = %w( app
                  dist
                  config
                  public
                  tests )

      files = %w( .ember-cli
                  Brocfile.js
                  bower.json
                  package.json )

      dirs_exist = dirs.all? do |dir_path|
        File.directory? File.join(app.root, 'ember', dir_path)
      end

      files_exist = files.all? do |file_path|
        File.file? File.join(app.root, 'ember', file_path)
      end

      dirs_exist && files_exist
    end

    def before_build
      in_ember_dir do
        system "ember build --environment=production"
        FileUtils.cp 'dist/index.html', '../source/layouts/layout.erb'
      end
    end

    def after_build
      in_ember_dir do
        FileUtils.rm 'dist/index.html'
        FileUtils.cp_r 'dist/.', '../build'
      end
    end

    private

    def in_ember_dir
      Dir.chdir(File.join(app.root,'ember')) do
        yield
      end
    end
  end
end
