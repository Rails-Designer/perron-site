---
section: content
order: 2
title: Generator
description: Use Perron's generator to easily create new collections and content files.
---

Create a new collection using the built-in generator.
```bash
bin/rails generate content Post
# or only include the needed action
bin/rails generate content Post show
```

This will create the following files:

* `app/content/posts/` (all `.md`, `.erb` content will be added here)
* `app/models/content/post.rb`
* `app/controllers/content/posts_controller.rb`
* `app/views/content/posts/index.html.erb`
* `app/views/content/posts/show.html.erb`

And adds a route: `resources :posts, module: :content, only: %w[index show]`


## Creating new content files

[!label v0.15.0+]

Once a collection is created, you can quickly generate new content files:
```bash
bin/rails generate content Post --new
bin/rails generate content Post --new "My First Post"
```

This creates a new file in `app/content/posts/` based on a template (if one exists).


### Using templates

Drop a template file in your content directory to define the structure for new files:

* `template.md.tt`: generates `untitled.md` or `my-first-post.md`
* `YYYY-MM-DD-template.md.tt`: generates `2025-12-18-untitled.md` or `2025-12-18-my-first-post.md`

Templates support ERB, so you can add dynamic content:
```erb
---
title: <%= @title %>
published_at: <%= Time.current %>
---

# <%= @title %>

Start writing here…
```

If no template exists, an empty file with frontmatter dashes is created.
