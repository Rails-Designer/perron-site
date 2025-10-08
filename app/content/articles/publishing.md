---
section: content
order: 3.7
title: Publishing & Scheduling
description: Control the visibility of your content by marking it as published, scheduled, or draft.
erb: true
---

Perron includes a system for managing the publication status of your resources. This allows you to create drafts, publish content immediately or schedule it to be published in the future.

This status is determined by looking at the resource's frontmatter or, as a fallback, the date in its filename.


## Setting the Publication Date

There are two ways to define when a piece of content should be considered published. Perron uses the first valid date it finds, checking in this order:


### Frontmatter (Recommended)

You can set a `published_at` key in the resource's frontmatter. This gives you precise control over the publication time. The value should be a valid date or datetime string.
```yaml
---
title: My Scheduled Post
published_at: <%= Time.current.yesterday.beginning_of_day %>
---
```

> [!note]
> If `published_at` is set to a time in the future, the content is considered **scheduled**.


### Filename

If `published_at` is not set in the frontmatter, Perron will attempt to parse a date from the resource's filename. The filename must be prefixed with a date in the format `YYYY-MM-DD-`.

For a file named `<%= Time.current.yesterday.strftime("%Y-%m-%d") %>-my-first-post.md`, the publication date will be set to the beginning of that day.


## Drafts

To prevent a resource from being published, you can mark it as a draft. This is useful for content that is not yet ready. There are two ways to do this in the frontmatter:

```yaml
---
title: This is a Work in Progress
draft: true
---
```

Alternatively, you can use `published: false`:

```yaml
---
title: Another Work in Progress
published: false
---
```

> [!note]
> A resource will not be published if `draft` is `true`, if `published` is `false` or if its publication date is in the future.


## Available Methods

The publishing logic adds several helpful methods to your resource objects.

| Method             | Description                                                                                               |
| :----------------- | :-------------------------------------------------------------------------------------------------------- |
| `published?`       | Returns `true` if the resource is currently visible to the public.                                        |
| `scheduled?`       | Returns `true` if the resource's publication date is in the future.                                       |
| `publication_date` | Returns the `Time` object for when the resource is/was published. Aliased as `published_at`.              |
| `scheduled_at`     | Returns the publication date, but only if the resource is scheduled (otherwise returns `nil`).             |


## Viewing Unpublished Content

For development or preview environments, you can globally override the publishing rules to make all content visible, including drafts and scheduled posts. This is done by setting `Perron.configuration.view_unpublished = true` (defaults to `Rails.env.development?`, so you can always preview your content in development) in your configuration.
