module Middleman
  class EmbermanExtension < Extension
    option :format,     :ember_cli, 'Ember format: :ember_cli (default) or :globals'
    option :directory,  :ember,     'Ember app directory relative to :js_dir'
    option :app_name,   :emberman,  'Name of your Ember app'

    def initialize(app, options_hash={}, &block)
      super

      register_child_extensions

      scoped_self = self

      app.configure :development do
        scoped_self.activate_child_extensions self
      end

      app.configure :build do
        scoped_self.activate_child_extensions self
      end
    end

    def register_child_extensions
      case options.format
      when :globals
        require_relative 'globals/globals.rb'
        Globals.register :emberman_globals
      else
        require_relative 'cli/cli.rb'
        CLI.register :emberman_cli
      end
    end

    def activate_child_extensions(app)
      case options.format
      when :globals
        app.activate :emberman_globals, directory: options.directory
      else
        app.activate :emberman_cli, app_name: options.app_name
      end
    end
  end
end
