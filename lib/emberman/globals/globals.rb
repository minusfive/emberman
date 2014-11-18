require 'sprockets/ember_handlebars_template'
require 'middleman-ember'

module Middleman
  class EmbermanExtension::Globals < Extension
    option :directory, :ember, 'Ember app directory relative to :js_dir'

    def initialize(app, options_hash={}, &block)
      super

      directory = options.directory

      app.configure :development do
        activate :ember
      end

      app.configure :build do
        activate :ember
        set :ember_variant, :production
        ignore File.join js_dir, directory, '*'
      end
    end

    def after_configuration
      templates_dir = File.join options.directory, 'templates'
      app.sprockets.engines['.handlebars'].options[:key_name_proc] = proc do |t|
        t.sub(%r~^#{templates_dir}/~, "")
      end
    end
  end
end
