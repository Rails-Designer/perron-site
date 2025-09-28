---
section: getting_started
order: 2
title: Configuration
description: Perron's global configuraton is set in an Initializer.
---

You can set Perron's global configuration in `config/initializers/perron.rb`.

This file is automatically created when you run `rails generate perron:install`.

It looks something like this:
```ruby
Perron.configure do |config|
  # config.output = "output"

  config.site_name = "Perron"

  # The build mode for Perron. Can be :standalone or :integrated.
  # config.mode = :standalone

  # In `integrated` mode, the root is skipped by default. Set to `true` to enable.
  # config.include_root = false

  config.default_url_options = {host: "perron.railsdesigner.com", protocol: "https", trailing_slash: true}

  # Set default meta values
  # Examples:
  # - `config.metadata.description = "Put your routine tasks on autopilot"`
  # - `config.metadata.author = "Helptail Team"`
end
```
