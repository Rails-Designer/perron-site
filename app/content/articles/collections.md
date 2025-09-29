---
section: content
order: 1
title: Collections
description: Collections can be used to similar content and resources, like posts, articles or people.
---

Perron is, just like Rails, designed with convention over configuration in mind.

Content is stored in `app/content/*/*.{erb,md,*}` and backed by a class, located in `app/models/content/` that inherits from `Perron::Resource`.

The controllers are located in `app/controllers/content/`. To make them available, create a route: `resources :posts, module: :content, only: %w[index show]`.


## Resource class

Every collection's class inherits from `Perron::Resource`, e.g.:
```ruby
class Content::Post < Perron::Resource
  # …
end
```

This gives each class its base behavior. It is just a regular Ruby class so you use common features:
```ruby
class Content::Post < Perron::Resource
  delegate :title, to: :metadata

  def loud_section
    metadata.section.upcase
  end
end
```


## `@resource` instance

In a `show` action, the resource (e.g. `Content::Post`) is expected to be set at `@resource`. For example:
```ruby
class Content::PostsController < ApplicationController
  def show
    @resource = Content::Post.find(params[:id])
  end
end
```

Currently various features from Perron rely on this instance variable being set. This is a known limitation and I hope to change it in a future version.


## Setting a root page

To set a root page, include `Perron::Root` in your `Content::PagesController` and add a `app/content/pages/root.{md,erb,*}` file. Then add `root to: "content/pages#root"` add the bottom of your `config/routes.erb`.

This is automatically added for you when you [create a `Page` collection](/docs/generator/).
