---
section: getting_started
order: 1
title: Quickstart
description: Learn how to get started quickly with Perron.
toc: false
---

Get started quickly with Perron by adding it to your existing Rails app or start a new (static) site.

## An existing app

Start by adding Perron:
```bash
bundle add perron
```

Then generate the initializer:
```bash
rails generate perron:install
```


This creates an initializer:
```ruby
Perron.configure do |config|
  config.site_name = "Helptail"

  # …
end
```


## A new site

Start a new Perron-based site by running this command:

```bash
rails new MyNewSite --minimal -T -O -m https://perron.railsdesigner.com/resources/new/template.rb
```

Read [more about this snippet](/resources/new/).
