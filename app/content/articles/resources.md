---
section: content
order: 1
title: Resources
description: Resources are a collection of similar content and resources, like posts, articles or people.
---

Perron is, just like Rails, designed with convention over configuration in mind.

All content is stored in `app/content/*/*.{erb,md,*}` and backed by a class, located in `app/models/content/` that inherits from `Perron::Resource`.

The controllers are located in `app/controllers/content/`. To make them available, create a route: `resources :posts, module: :content, only: %w[index show]`.


## Resource class

Every resource class inherits from `Perron::Resource`, e.g.:
```ruby
# app/models/content/post.rb
class Content::Post < Perron::Resource
end
```

This gives each class its base behavior. It is just a regular Ruby class so you can use common features:
```ruby
# app/models/content/post.rb
class Content::Post < Perron::Resource
  delegate :title, to: :metadata

  def loud_category
    metadata.category.upcase
  end
end
```


### Validate your content

Just like Rails' ActiveModel classes, you can validate values from your resource class, for example your frontmatter.

Perron offers a `bin/rails perron:validate` task that runs all validations and outputs any failures. Output could look like this:
```console
rails perron:validate
..........................F.....
Resource: /perron/docs/app/content/articles/resources.md
  - Description can't be blank

Validation finished with 1 failure.
```

Useful to check if your title or meta description is within the correct range for SERP's or to make sure you added the correct category or tags.
```ruby
class Content::Post < Perron::Resource
  CATEGORIES = %w[rails ruby hotwire javascript updates]
  delegate :category, :title, :description, to: :metadata

  validates :title, :description, presence: true
  validates :category, inclusion: { in: CATEGORIES }

  # …
end
```

If you want to validate your frontmatter, make them callable in the class, as seen above using `delegate`.


## `@resource` instance

In a `show` action, a resource instance variable is expected to be set.
```ruby
class Content::PostsController < ApplicationController
  def show
    @resource = Content::Post.find(params[:id])
  end
end
```

> [!note]
> Currently various features from Perron rely on this instance variable being explicitly set as `@resource`. This is a known limitation and I hope to change it in a future version.


## Setting a root page

To set a root page, include `Perron::Root` in your `Content::PagesController` and add a `app/content/pages/root.{md,erb,*}` file. Then add `root to: "content/pages#root"` add the bottom of your `config/routes.erb`.

This is automatically added for you when you [create a `Page` collection](/docs/generator/).
