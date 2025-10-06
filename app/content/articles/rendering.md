---
section: content
order: 4
title: Rendering & filtering
description: Perron's resources are just Ruby objects so it is straight-forward to select, filter and order resources.
---

Perron's resources are just Ruby objects so it is straight-forward to render, filter and order resources.


## Resource content

To render a resource's content, use `@resource.content`.


## Rendering resources

If you want to render a list of resources, use `Content::Post.all`. You can also pass the array to `render`, just like with ActiveRecord models.

```erb
<%= render Content::Post.all %>
```

This expects a partial `app/views/content/posts/_post.html.erb`.


Or set a partial, and pass the collection:
```erb
<%= render partial: "content/posts/custom", collection: Content::Post.all %
```


## Enumerable methods

All typical enumerable methods are available on Perron's resources.


### Filtering

```ruby
published_posts = Content::Post.all.select { it.published? }
ruby_posts = Content::Post.all.select { it.metadata.category == "ruby" }
recent_posts = Content::Post.all.reject { it.published_at < 1.month.ago }
```


### Transformation

```ruby
titles = Content::Post.all.map(&:title)
slugs_with_titles = Content::Post.all.map { [it.slug, it.title] }.to_h
```


### Sorting

```ruby
sorted_by_date = Content::Post.all.sort_by(&:date)
sorted_by_title = Content::Post.all.sort_by(&:title)
newest_first = Content::Post.all.sort_by(&:date).reverse
```


### Limiting

```ruby
first_three = Content::Post.all.first(3)
most_recent = Content::Post.all.sort_by(&:date).reverse.first(5)
```


### Finding

```ruby
ruby_tutorial = Content::Post.all.find { it.title.include?("Ruby Tutorial") }
posts_with_images = Content::Post.all.select { it.content.include?("![") } # assuming markdown usage
```


### Grouping

```ruby
posts_by_category = Content::Post.all.group_by(&:category)
posts_by_year = Content::Post.all.group_by { it.published_at.year }
```


### Counting

```ruby
total_posts = Content::Post.all.count
published_count = Content::Post.all.count { it.published? }
category_counts = Content::Post.all.group_by(&:category).transform_values(&:count) # assuming `category` is delegated to `metadata`
```


### Checking conditions

```ruby
has_ruby_posts = Content::Post.all.any? { it.metadata.category == "ruby" }
all_published = Content::Post.all.all? { it.published? }
```


### Group published posts by category

Sorted by date within each category.

```ruby
categorized_posts = Content::Post.all
  .select { it.published? }
  .group_by(&:category)
  .transform_values { it.sort_by(&:date).reverse }
```
