# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'emberman/version'

Gem::Specification.new do |spec|
  spec.name          = 'emberman'
  spec.version       = Middleman::Emberman::VERSION
  spec.authors       = ['minusfive']
  spec.email         = ['mail@minusfive.com']
  spec.summary       = %q{Middleman + Ember, sitting in a tree...}
  spec.description   = %q{An easy way to get an Ember app served by a Middleman static site.}
  spec.homepage      = 'http://github.com/minusfive/emberman'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency     'middleman-core',                 '~> 3.3.7'
  spec.add_runtime_dependency     'middleman-ember',                '~> 0.2.3'
  spec.add_runtime_dependency     'sprockets-handlebars_template',  '~> 1.0.0'
  spec.add_runtime_dependency     'handlebars-source',              '2.0.0'
  spec.add_runtime_dependency     'ember-source',                   '1.9.0.beta.3'
  spec.add_runtime_dependency     'ember-data-source',              '1.0.0.beta.12'

  spec.add_development_dependency 'bundler', '~> 1.7.7'
  spec.add_development_dependency 'rake', '~> 10.4.0'
end
