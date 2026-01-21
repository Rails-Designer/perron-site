---
section: getting_started
order: 1
title: Quick-start guide
description: Learn how to get started quickly with Perron.
---

Get started quickly with Perron by adding it to your existing Rails app or start a new static site.

## Already have a Rails app?

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
  config.site_name = "Chirp Form"

  # …
end
```


## Start from scratch?

Start a new Perron-based site by running this command:
```bash
rails new MyNewSite --minimal -T -O -m https://perron.railsdesigner.com/library/new/template.rb
```

> [!note]
> This is a snippet from the Perron [library](/library/), read [more about this snippet here](/library/new/).


## Create your first content

Perron works with resources, e.g. pages or posts. [Learn about collections](/docs/resources/) and [how to generate one](/docs/generator/).
