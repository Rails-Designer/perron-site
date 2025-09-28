---
section: content
order: 4
title: Markdown
description: Perron can render markdown with a flexible helper that has support for multiple markdown gems.
---

Perron supports markdown with the `markdownify` helper.

There are no markdown gems bundled by default, so you'll need to add one of these to your `Gemfile`:

- `commonmarker`
- `kramdown`
- `redcarpet`

```bash
bundle add {commonmarker,kramdown,redcarpet}
```

This flexible set up allows you to choose your favorite markdown rendering gem.


## Usage

Once a markdown is installed, you can use the `markdownify` helper in any view, e.g.
```erb
<article class="content">
  <h1>
    <%= @resource.title %>
  </h1>

  <%= markdownify(@resource.content) %>
</article>
```

You can also pass a block:
```erb
<article class="content">
  <h1>
    <%= @resource.title %>
  </h1>

  <%= markdownify do %>
    <<~MARKDOWN
      Perron supports markdown with the `markdownify` helper.

      There are no markdown gems bundled by default, so you'll need to add one of these to your `Gemfile`:

      - `commonmarker`
      - `kramdown`
      - `redcarpet`

      ```bash
      bundle add {commonmarker,kramdown,redcarpet}
      ```
    MARKDOWN
  <% end %>
</article>
```

## Configuration

To pass options to the parser, set `markdown_options` in `config/initializers/perron.rb`. The options hash is passed directly to the chosen library.

**Commonmarker**
```ruby
# Options are passed as keyword arguments.
Perron.configuration.markdown_options = { options: [:HARDBREAKS], extensions: [:table] }
```

**Kramdown**
```ruby
# Options are passed as a standard hash.
Perron.configuration.markdown_options = { input: "GFM", smart_quotes: "apos,quot" }
```

**Redcarpet**
```ruby
# Options are nested under :renderer_options and :markdown_options.
Perron.configuration.markdown_options = {
  renderer_options: { hard_wrap: true },
  markdown_options: { tables: true, autolink: true }
}
```


## HTML transformations

Perron can post-process the HTML generated from your Markdown content.


### Usage

Apply transformations by passing an array of processor names or classes to the `markdownify` helper via the `process` option.
```erb
<%= markdownify(@resource.content, process: %w[lazy_load_images syntax_highlight target_blank]) %>
```


### Available processors

The following processors are built-in and can be activated by passing their string name:

- `target_blank`: Adds `target="_blank"` to all external links;
- `lazy_load_images`: Adds `loading="lazy"` to all `<img>` tags.
- `syntax_highlight`: Applies syntax highlighting to fenced code blocks (e.g., \`\`\`ruby).


### Create your own processor

You can create your own processor by defining a class that inherits from `Perron::HtmlProcessor::Base` and implements a `process` method.
Then, pass the class constant directly in the `process` array.

```ruby
# app/processors/add_nofollow_processor.rb
class AddNofollowProcessor < Perron::HtmlProcessor::Base
  def process
    @html.css("a[target=_blank]").each { it["rel"] = "nofollow" }
  end
end
```

```erb
<%= markdownify(@resource.content, process: ["target_blank", AddNofollowProcessor]) %>
```


## Syntax highlighting

For the markdown gems that do not have syntax highlighting support out-of-the-box, you can enable the `syntax_highlight` processor as described above. This also requires adding the `rouge` gem to your Gemfile (`bundle add rouge`).

For the `syntax_highlight` processor to render colors, add a CSS theme from the `rouge` gem to your application's assets.

1. **Generate the Stylesheet:** Use the `rougify` command-line tool that comes with the gem to create a CSS file. Run the following command in your terminal, replacing `github` with your preferred theme.
```shell
bundle exec rougify style github > app/assets/stylesheets/rouge-theme.css
```

This command takes the `github` theme and saves it as a standard CSS file that Propshaft can serve directly *(to see a list of all available themes, run `bundle exec rougify help style`)*.

2. **Include the Stylesheet:** Add the generated file to your application's layout (e.g., `app/views/layouts/application.html.erb`). The standard Rails helper works perfectly.
```erb
<%= stylesheet_link_tag "rouge-theme", media: "all" %>
```
