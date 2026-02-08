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
  resources :posts, module: :content, only: %w[index show]
  resources :pages, module: :content, only: %w[show]

  root to: "content/pages#root"
end
```

## Route configuraton

Change the site's route configuration in `config/initializers/perron.rb`:
```ruby
Perron.configure do |config|
  # …
  config.default_url_options = {host: "perron.railsdesigner.com", protocol: "https", trailing_slash: true}
  # …
end
```

For a typical “clean slug”, the filename without extension serves as the `id` parameter.
```ruby
<%# For app/content/posts/announcement.md %>
<%= link_to "Announcement", post_path("announcement") %>
```
This would render `<a href="/posts/announcement/">Announcement</a>`.
