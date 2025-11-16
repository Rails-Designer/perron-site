---
section: getting_started
order: 2
title: Configuration
description: Perron's global configuraton is set in an Initializer.
toc: false
---

You can set Perron's global configuration in `config/initializers/perron.rb`.

This file is automatically created when you run `rails generate perron:install`.

It looks something like this:
```ruby
Perron.configure do |config|
  config.site_name = "Perron"

  config.default_url_options = {host: "perron.railsdesigner.com", protocol: "https", trailing_slash: true}
end
```

## All settings

Below are available settings:

- **site_name**; your site's name, used as fallback for meta tags
- **site_description**; your site's description; used as fallback for meta tags
- **site_email**; your site's email
- **output**; defaults to `output`
- **mode**; defaults to `standalone`
- **include_root**; in `integrated` mode, root route is excluded by default, override here
- **allowed_extensions**; set which extensions for content files are allowed, defaults to `%w[erb md]`
- **exclude_from_public**; exclude directories with compiled files should be excluded from `public`, defaults to `%w[assets storage]`
- **excluded_assets**; exclude which assets shoud be excluded when compiling, defaults to `%w[action_cable actioncable actiontext activestorage rails-ujs trix turbo]`
- **view_unpublished**; option to show [unpublished content](/docs/publishing/) content, defaults to `Rails.env.development?`
- **default_url_options**; set options for route helpers
- **markdown_parser**; specifiy custom markdown parser
- **markdown_options**; pass options for your markdown gem
- **sitemap.enabled**; enable creation of the sitemap.xml, defaults to `false`
- **sitemap.priority**; default priority for sitemap items, defaults to `0.5`
- **sitemap.change_frequency**; default value for change_frequency, defaults to `:monthly`
