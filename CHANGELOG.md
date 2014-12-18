# Emberman Changelog [![Gem Version](https://badge.fury.io/rb/emberman.svg)](http://badge.fury.io/rb/emberman)

### 0.1.3 (2014/12/18)
- Upgrade default Ember to [v1.9.0 (stable)](https://github.com/emberjs/ember.js/blob/v1.9.0/CHANGELOG.md)

### 0.1.2 (2014/11/28)
- Upgrade default Ember to [v1.9.0.beta.3](https://github.com/emberjs/ember.js/blob/v1.9.0-beta.3/CHANGELOG.md)
- Upgrade default Ember Data to [v1.0.0.beta.12](https://github.com/emberjs/data/blob/v1.0.0-beta.12/CHANGELOG.md)
- Upgrade default Handlebars to [v2.0.0](https://github.com/wycats/handlebars.js/blob/v2.0.0/release-notes.md)
- Upgrade middleman-core, bundler and rake dependencies to latest versions

### 0.1.1 (2014/11/04)
- Upgrade default Ember to [v1.8.1 (stable)](https://github.com/emberjs/ember.js/blob/v1.8.1/CHANGELOG.md)

### 0.1 (2014/11/03)
- Upgrade default Ember to [v1.8.0 (stable)](https://github.com/emberjs/ember.js/blob/v1.8.0/CHANGELOG.md)

### 0.0.4 (2014/10/19)
- Upgrade default Ember to [v1.8.0.beta.5](https://github.com/emberjs/ember.js/blob/v1.8.0-beta.5/CHANGELOG.md)
- Upgrade default Ember Data to [v1.0.0.beta.11](https://github.com/emberjs/data/blob/v1.0.0-beta.11/CHANGELOG.md)

### 0.0.3 (2014/09/29)
- Upgrade default Ember to [v1.8.0.beta.3](https://github.com/emberjs/ember.js/blob/v1.8.0-beta.3/CHANGELOG.md)

### 0.0.2 (2014/09/24)
- Minor cleanup

### 0.0.1 (2014/09/23)
- Auto-load:
  + Ember [1.8.0.beta.2](https://github.com/emberjs/ember.js/releases/tag/v1.8.0-beta.2)
  + Ember Data [1.0.0.beta.10](https://github.com/emberjs/data/releases/tag/v1.0.0-beta.10)
  + Handlebars [1.3.0](https://github.com/wycats/handlebars.js/releases/tag/v1.3.0)
- `:app_dir` option allows you to set a custom Ember app directory (relative to Middleman's `:js_dir`)
- Pre-compile handlebars templates (from `templates` directory inside the Ember app directory (`:app_dir`))
- Use production versions of Ember + Ember Data on `build`
- Ignore ingredient files on `build`
