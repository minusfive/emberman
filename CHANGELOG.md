# Emberman Changelog

### 0.0.2 (2014/09/24)
Minor cleanup

### 0.0.1 (2014/09/23)

Initial gem release, with:
  - Auto-load:
    + [Ember 1.8.0.beta.2](https://github.com/emberjs/ember.js/releases/tag/v1.8.0-beta.2)
    + [Ember Data 1.0.0.beta.10](https://github.com/emberjs/data/releases/tag/v1.0.0-beta.10)
    + [Handlebars 1.3.0](https://github.com/wycats/handlebars.js/releases/tag/v1.3.0)
  - `:app_dir` option allows you to set a custom Ember app directory (relative to Middleman's `:js_dir`)
  - Pre-compile handlebars templates (from `templates` directory inside the Ember app directory (`:app_dir`))
  - Use production versions of Ember + Ember Data on `build`
  - Ignore ingredient files on `build`
