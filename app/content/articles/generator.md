---
section: content
order: 2
title: Generator
description: Use Perron's geenrator to easily create new collections.
---

Create a new collection using the built-in generator.
```bash
bin/rails generate content Post
```
This will create the following files:

* `app/models/content/post.rb`
* `app/controllers/content/posts_controller.rb`
* `app/views/content/posts/index.html.erb`
* `app/views/content/posts/show.html.erb`

And adds a route: `resources :posts, module: :content, only: %w[index show]`
