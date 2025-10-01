---
section: content
order: 5
title: Embed Ruby
description: Perron has flexible support for rendering Ruby.
erb: true
---

Perron provides flexible options for embedding dynamic Ruby code in your content using ERB.


## File extension

Any content file with a `.erb` extension (e.g., `about.erb`) will automatically have its content processed as ERB.


## Frontmatter

You can enable ERB processing on a per-file basis, even for standard `.md` files, by adding `erb: true` to the file's frontmatter (like [this markdown file you are looking at](<%= edit_on_github_url(@resource) %>)).
```markdown
---
title: Embed Ruby
erb: true
---

This entire page will be processed by ERB.
The current time is: <%= Time.current.strftime("%d %B %Y") %>
↳ uses `<%%= Time.current.strftime("%d %B %Y") %>`
```


## `erbify` helper

For the most granular control, the `erbify` helper allows to process specific sections of a file as ERB. This is ideal for generating dynamic content like lists or tables from your resource's metadata, without needing to enable ERB for the entire file. The `erbify` helper can be used with a string or, more commonly, a block.

**Example:** Generating a list from frontmatter data in a standard `.md` file.
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
