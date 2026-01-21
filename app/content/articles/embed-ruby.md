---
section: content
order: 5
title: Embed Ruby
description: Perron has flexible support for rendering Ruby.
erb: true
---

Perron provides flexible options for embedding Ruby code using ERB.


## File extension

Any content file with a `.erb` extension (e.g., `about.erb`) will automatically have its content processed as ERB.


## Frontmatter

Enable ERB processing on a per-file basis, even for standard `.md` files, by adding `erb: true` to the file's frontmatter (like [this article's markdown file](<%= view_on_github_url("app/content/articles/embed-ruby.md") %>)).
```markdown
---
title: Embed Ruby
erb: true
---

This entire page will be processed by ERB.
The current date (upon building this site) is: <%= Time.current.strftime("%d %B %Y") %>
↳ uses `<%%= Time.current.strftime("%d %B %Y") %>`
```


## `erbify` helper

For the most granular control, the `erbify` helper allows to process specific sections of a file as ERB. This is ideal for generating dynamic content like lists or tables from the resource's frontmatter, without needing to enable ERB for the entire file.

**Example:** generating a list from frontmatter data in a standard `.md` file.
```markdown
---
title: Features
features:
  - Rails based
  - SEO friendly
  - Markdown first
  - ERB support
---

Check out our amazing features:

<%%= erbify do %>
  <ul>
    <%% @resource.metadata.features.each do |feature| %>
      <li>
        <%%= feature %>
      </li>
    <%% end %>
  </ul>
<%% end %>
```

This would iterate over the `features` array and display its value within the `li`-element.


## Rendering erb-tags

When needing to show actual ERB tags (rather than having them processed), to escape them by doubling the percent signs. For example: `<%%` and `<%%=`.
