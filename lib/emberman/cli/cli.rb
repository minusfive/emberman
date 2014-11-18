require 'middleman/rack'
module Middleman
  class EmbermanExtension::CLI < Extension
    option :app_name, :emberman, 'Name of your Ember app'

    def initialize(app, options_hash={}, &block)
      super

      emberman_cli = self

      app.configure :development do
        sitemap.invalidate_resources_not_ignored_cache!
      end

      app.configure :build do
        sitemap.invalidate_resources_not_ignored_cache!
      end

      app.after_configuration do
        # Add ember directory to list of ignored files
        config[:file_watcher_ignore] += [/^ember(\/|$)/]
      end

      app.ready do
        # app = self
        if emberman_cli.ember_dir_exists?
          if emberman_cli.ember_cli_app_initialized?
            emberman_cli.start_ember_server
          else
            emberman_cli.initialize_ember_cli_app
          end
        else
          emberman_cli.generate_ember_cli_app
        end
      end
    end

    def start_ember_server
      app.logger.info '== Emberman: Starting ember-cli server'
      Dir.chdir(File.join(app.root,'ember')) do
        system 'ember s --proxy http://localhost:4567 &', err: :out
      end
    end

    def initialize_ember_cli_app
      app_name = options.app_name.dasherize
      app.logger.info "== Emberman: Initializing ember-cli app \"#{app_name}\" in ./ember directory"
      Dir.chdir(File.join(app.root,'ember')) do
        system "ember init #{app_name}", err: :out
      end
      start_ember_server
    end

    def generate_ember_cli_app
      app_name = options.app_name.dasherize
      app.logger.info "== Emberman: Generating ember-cli app \"#{app_name}\" in ./ember directory"
      Dir.chdir(app.root) do
        system "ember new #{app_name}", err: :out
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
  end
end
