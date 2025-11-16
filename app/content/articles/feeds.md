---
section: metadata
order: 9
title: Feeds (RSS and JSON)
description: Perron can create RSS and JSON feeds from your collections.
---

Perron can create RSS and JSON feeds of your collections.

The `feeds` helper automatically generates HTML `<link>` tags for your site's RSS and JSON feeds.


## Usage

In your layout (e.g., `app/views/layouts/application.html.erb`), add the helper to the `<head>` section:
```erb
<head>
  …
  <%= feeds %>
  …
</head>
```

To render feeds for specific collections, such as `posts`:
```erb
<%= feeds only: %w[posts] %>
```

Similarly, you can exclude collections:
```erb
<%= feeds except: %w[pages] %>
```


## Configuration

Feeds are configured within the `Resource` class corresponding to a collection:
```ruby
# app/models/content/post.rb
class Content::Post < Perron::Resource
  configure do |config|
    config.feeds.rss.enabled = true
    # config.feeds.rss.title = "My RSS feed" # defaults to configured site_name
    # config.feeds.rss.description = "My RSS feed description" # defaults to configured site_description
    # config.feeds.rss.path = "path-to-feed.xml"
    # config.feeds.rss.max_items = 25
    # config.feeds.rss.ref = "chirpform.com" # adds ?ref=chirpform.com to item links for tracking
    #
    config.feeds.json.enabled = true
    # config.feeds.json.title = "My JSON feed" # defaults to configured site_name
    # config.feeds.json.description = "My JSON feed description" # defaults to configured site_description
    # config.feeds.json.max_items = 15
    # config.feeds.json.path = "path-to-feed.json"
    # config.feeds.json.ref = "chirpform.com" # adds ?ref=chirpform.com to item links for tracking
  end
end
```
