# Emberman [v0.0.1](CHANGELOG.md)

[Middleman](http://middlemanapp.com/) + [Ember](http://emberjs.com/), sitting in a tree...

## Emberwhat?

Emberman is a simple [extension](http://middlemanapp.com/advanced/custom/) which allows you to easily serve an [Ember](http://emberjs.com/) app from your [Middleman](http://middlemanapp.com/) static site. It works by wrapping other [excellent gems](#thanks), along with some basic configuration, to get you quickly started.

## Features

  - Auto-loads into [Middleman's Asset Pipeline](http://middlemanapp.com/basics/asset-pipeline/):
    + [Ember 1.8.0.beta.2](https://github.com/emberjs/ember.js/releases/tag/v1.8.0-beta.2)
    + [Ember Data 1.0.0.beta.10](https://github.com/emberjs/data/releases/tag/v1.0.0-beta.10)
    + [Handlebars 1.3.0](https://github.com/wycats/handlebars.js/releases/tag/v1.3.0)
  - Pre-compiles handlebars templates
  - Uses production versions of Ember + Ember Data on `build`
  - Ignores ingredient files on `build`, compiles into a single JS file

## Installation

Add this line to your Middleman application's `Gemfile`:

```ruby
# Gemfile

gem 'emberman', github: 'minusfive/emberman'
```

Then run:

```shell
$ bundle
```

Activate the extension from your Middleman site's `config.rb` file:

```ruby
# config.rb

activate :emberman
```

Start the Middleman server.

```shell
$ middleman
```

## Other requirements

For now, Ember's [and Emberman's] only other requirement is for **jQuery** to be present. This may change soon ;)

## Configuration

Emberman expects you to follow certain conventions in order to work its magic. However, some basic customization options are allowed:

### Default directory structure

Emberman, by default, expects your *Ember app's main JavaScript file* to live in your Middleman site's JavaScript assets directory (`source/javascripts`).

**Ember assets** (models, controllers, views, routes, etc.) should be placed in an **`ember` directory**, _nested under_ your **JavaScript assets** directory. The **Handlebars templates** directory _must_ live _inside_ the `ember` directory, and be **named `templates`**. These templates should use the standard `.hbs` or `.handlebars` file extensions. E.g.:

```
my-middleman-site/
  |
  + source/
  |    |
  |    + javascripts/ <- Middleman's default JavaScript assets directory
  |         |
  |         + app.js  <- Main Ember app file, any name works
  |         |
  |         + ember/  <- Ember assets directory
  |              |
  |              + templates/
  |              |    |
  |              |    + index.hbs
  |              |    + ...
  |              |
  |              + routes/...
  |              + models/...
  |              + controllers/...
  |              + views/...
  |              + components/...
  |              + adapters/...
  |              + ...
  |         
  + config.rb
  + Gemfile
  + ...
```

### Custom directory names

Middleman allows you to customize the JavaScript assets directory by setting the `:js_dir` property in your `config.rb`.

Likewise, you can set a custom name for your Ember assets directory by passing an `:app_dir` option when you activate the extension in your `config.rb`. The Ember assets directory will _always_ be **relative to** Middleman's JavaScript assets directory. E.g.:

```ruby
# config.rb

set :js_dir, 'assets/js' # Set Middleman's JavaScript directory
activate :emberman, app_dir: 'my-ember-app' # Ember assets dir name
```

```
my-middleman-site/
  |
  + source/
  |    |
  |    + assets/
  |    |    |
  |    |    + js/                 <- JavaScript assets directory
  |    |       |
  |    |       + my-ember-app.js  <- Main Ember app file, any name works
  |    |       |
  |    |       + my-ember-app/    <- Ember assets directory
  |    |            |
  |    |            + templates/
  |    |            |    |
  |    |            |    + index.hbs
  |    |            |    + ...
  |    |            |
  |    |            + routes/...
  |    |            + models/...
  |    |            + controllers/...
  |    |            + views/...
  |    |            + components/...
  |    |            + adapters/...
  |    |            + ...
  |         
  + config.rb
  + Gemfile
  + ...
```

### Including the assets

Once you've setup the directories/files following the aforementioned conventions, you can include the assets in your main Ember app's JS file through [Middleman's Asset Pipeline](http://middlemanapp.com/basics/asset-pipeline/). Note that **only the Runtime version of Handlebars** is necessary, since the templates are [pre-compiled](http://handlebarsjs.com/precompilation.html). E.g.:

```javascript
//= require jquery
//= require handlebars.runtime
//= require ember
//= require ember-data
//= require_self
//= require ./ember/router
//= require_tree ./ember/templates
//= require_tree ./ember/adapters
//= require_tree ./ember/components
//= require_tree ./ember/controllers
//= require_tree ./ember/models
//= require_tree ./ember/routes
//= require_tree ./ember/views


```

### Using other versions of Ember, Ember Data or Handlebars

If you'd prefer to use different versions of Ember, Ember Data or Handlebars, add their corresponding source gems to your `Gemfile`:

```ruby
# Gemfile

gem 'ember-source',       '1.7.0'
gem 'ember-data-source',  '0.14'
gem 'handlebars-source',  '1.2.1'
gem 'emberman'
```

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md).

## License

See [LICENSE](LICENSE.md).

## Thanks

- To [@mrship](https://github.com/mrship) for the [middleman-ember](https://github.com/mrship/middleman-ember) gem, used by Emberman
- To [@GutenYe](https://github.com/GutenYe) for the [sprockets-handlebars_template](https://github.com/GutenYe/sprockets-handlebars_template), also used by Emberman
- To [@tdreyno](https://github.com/tdreyno), [@bhollis](https://github.com/bhollis) and the [other contributors](https://github.com/middleman/middleman/graphs/contributors) of the excellent [Middleman](http://middlemanapp.com) static site generator
- And to [@wycats](https://github.com/wycats), [@tomdale](https://github.com/tomdale), [@wagenet](https://github.com/wagenet), [@stefanpenner](https://github.com/stefanpenner), [@rwjblue](https://github.com/rwjblue), [@ebryn](https://github.com/ebryn), [@machty](https://github.com/machty), [@trek](https://github.com/trek) and the [rest of the contributors](https://github.com/emberjs/ember.js/graphs/contributors) of the incredible [Ember.js](http://emberjs.com/) framework, as well as Ember Data and [Handlebars](http://handlebarsjs.com/)
