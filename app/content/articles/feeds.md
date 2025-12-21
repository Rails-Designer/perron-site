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
    # config.feeds.rss.ref = "rss-feed" # adds `?ref=rss-feed` to item links for tracking
    #
    config.feeds.json.enabled = true
    # config.feeds.json.title = "My JSON feed" # defaults to configured site_name
    # config.feeds.json.description = "My JSON feed description" # defaults to configured site_description
    # config.feeds.json.max_items = 15
    # config.feeds.json.path = "path-to-feed.json"
    # config.feeds.json.ref = "json-feed" # adds `?ref=json-feed` to item links for tracking
  end
end
```


## Author

[!label v0.16.0+]

Feeds can include optional author information. Set a default author for the collection:
```ruby
class Content::Post < Perron::Resource
  configure do |config|
    config.feeds.author = {
      name: "Rails Designer",
      email: "support@railsdesigner.com"
    }
  end
end
```

Individual resources can override this using a [`belongs_to :author` relationship](/docs/resources/#associations):
```ruby
class Content::Post < Perron::Resource
  belongs_to :author
end
```

```markdown
---
title: My Post
author_id: kendall
---
```

> [!NOTE]
> RSS feeds require an email address. JSON feeds only require a name. Both support optional `url` and `avatar` fields.


### Using a data file

If you prefer to manage authors in a data file instead of individual content resources, you can create a YAML file in `app/content/data/` (e.g., `app/content/data/authors.yml` or `app/content/data/team.yml`):
```yaml
kendall:
  name: Kendall
  email: kendall@railsdesigner.com
  url: https://example.com
  avatar: /images/kendall.jpg
  bio: Software developer and writer
  myspace: kendall-rd
```

For feeds to work, your data must include at least `name` and `email` keys (or just `name` for JSON feeds). You can add any additional keys for your own use.

Then override the `author` method in your resource model:
```ruby
class Content::Post < Perron::Resource
  def author
    super || Perron::Site.data.authors[metadata.author_id]
  end
end
```
