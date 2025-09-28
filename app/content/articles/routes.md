---
section: content
order: 3
title: Routes
description: Perron uses Rails' routing mechanism, keeping things simple and easy.
---

Perron uses standard Rails routing, allowing the use of familiar route helpers.

The `config/routes.rb` could look like this:
```ruby
Rails.application.routes.draw do
  resources :articles, module: :content, only: %w[index show]
  resources :pages, path: "/", module: :content, only: %w[show]

  root to: "content/pages#root"
end
```

## Route configuraton

In `config/initializers/perron.rb` you can change your site's route configuraton:
```ruby
Perron.configure do |config|
  # …
  config.default_url_options = {host: "perron.railsdesigner.com", protocol: "https", trailing_slash: true}
  # …
end
```

For a typical “clean slug”, the filename without extensions serves as the `id` parameter.
```ruby
<%# For app/content/pages/about.md %>
<%= link_to "About Us", page_path("about") %> # => <a href="/about/">About Us</a>
```


## Include extension

By default Perron creates clean slugs, like `/about/`. To create pages with specific extensions directly (e.g., `pricing.html`), the route must first be configured to treat the entire filename as the ID. In `config/routes.rb`, modify the generated `resources` line by adding a `constraints` option:

```ruby
# Change from…
resources :pages, module: :content, only: %w[show]

# …to…
resources :pages, module: :content, only: %w[show], constraints: { id: /[^\/]+/ }
```

With this change, a content file named `app/content/pages/pricing.html.erb` can be linked like so:
```ruby
<%= link_to "View Pricing", page_path("pricing", format: :html) %> # => <a href="/pricing.html">View Pricing</a>
```

Perron will then create `pricing.html` upon build.
