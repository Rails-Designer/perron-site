---
section: content
order: 8
title: Metatags
description: Use Perron's metatags helper to insert meta tags, like title, description and og-tags.
---

The `meta_tags` helper automatically generates SEO and social sharing meta tags for your pages.


## Usage

In your layout (e.g., `app/views/layouts/application.html.erb`), add the helper to the `<head>` section:
```erb
<head>
  …
  <%= meta_tags %>
  …
</head>
```

You can render specific subsets of tags:
```erb
<%= meta_tags only: %w[title description] %>
```

Or exclude certain tags:
```erb
<%= meta_tags except: %w[twitter_card twitter_image] %>
```


## Priority

Values are determined with the following precedence, from highest to lowest:


### 1. Controller action

Define a `@metadata` instance variable in your controller:
```ruby
class Content::PostsController < ApplicationController
  def index
    @metadata = {
      title: "All Blog Posts",
      description: "A collection of our articles."
    }
    @resources = Content::Post.all
  end
end
```


### 2. Page frontmatter

Add values to the YAML frontmatter in content files:
```yaml
---
title: My Awesome Post
description: A deep dive into how meta tags work.
image: /assets/images/my-awesome-post.png
author: Kendall
---

Your content here…
```


### 3. Collection configuration

Set collection defaults in the resource model:
```ruby
class Content::Post < Perron::Resource
  Perron.configure do |config|
    # …

    config.metadata.description = "Put your routine tasks on autopilot"
    config.metadata.author = "Helptail team"
  end
end
```


### 4. Default values

Set site-wide defaults in the initializer:
```ruby
Perron.configure do |config|
  # …

  config.metadata.description = "Put your routine tasks on autopilot"
  config.metadata.author = "Helptail team"
end
```


## Generated HTML Tags

Below is a complete list of the HTML tags that the `meta_tags` helper can generate. The helper will only render a tag if its corresponding data (e.g., content or href) is present.

```html
<title>…</title>
<link rel="canonical" href="…">
<meta name="description" content="…">
<meta property="article:published_time" content="…">
<meta property="og:title" content="…">
<meta property="og:type" content="…">
<meta property="og:url" content="…">
<meta property="og:image" content="…">
<meta property="og:description" content="…">
<meta property="og:site_name" content="…">
<meta property="og:logo" content="…">
<meta property="og:author" content="…">
<meta property="og:locale" content="…">
<meta name="twitter:card" content="…">
<meta name="twitter:title" content="…">
<meta name="twitter:description" content="…">
<meta name="twitter:image" content="…">
```
