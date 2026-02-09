---
section: content
position: 3.5
title: Frontmatter
description: Frontmatter is supported for markdown files.
toc: false
---

Perron supports frontmatter. It is a way to set metadata for that content, using yaml—a key-value system.

It is added at the beginning of the markdown file and set between three dashes (`---`). Something like this:
```yaml
---
title: Frontmatter
description: Frontmatter is supported for markdown files.
---
```

And it is typically used for data that is not directly visible, like for [metatags](/docs/metatags/).


## Usage

All defined frontmatter on a resource is available at the `metadata` method. Given above example, `@resource.metadata.title` and `@resource.metadata.description` would work.
