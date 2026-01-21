---
section: content
order: 4
title: Markdown
description: Perron can render markdown with a flexible helper that has support for multiple markdown gems.
---

Perron supports markdown with the `markdownify` helper.

There are no markdown gems bundled by default, so add one of these to the `Gemfile`:

- `commonmarker`
- `kramdown`
- `redcarpet`

```bash
# choose one
bundle add {commonmarker,kramdown,redcarpet}
```

This set up allows to change markdown renderers and update it separately from Perron.


## Markdownify helper

Once a markdown gem is installed, use the `markdownify` helper in any view and it will parse the content using the installed markdown parser, e.g.
```erb
<article class="content">
  <h1>
    <%= @resource.title %>
  </h1>

  <%= markdownify @resource.content %>
</article>
```

Pass a block:
```erb
<article class="content">
  <h1>
    <%= @resource.title %>
  </h1>

  <%= markdownify do %>
    Perron supports markdown with the `markdownify` helper.

    There are no markdown gems bundled by default, so add one of these to the `Gemfile`:

    - `commonmarker`
    - `kramdown`
    - `redcarpet`

    ```bash
    bundle add {commonmarker,kramdown,redcarpet}
    ```
  <% end %>
</article>
```

## Configuration

To pass options to the parser, set `markdown_options` in `config/initializers/perron.rb`. The options hash is passed directly to the chosen library.

```ruby
Perron.configure do |config|
  # …
  # Commonmarker
  # Options are passed as keyword arguments.
  config.markdown_options = { options: [:HARDBREAKS], extensions: [:table] }

  # Kramdown
  # Options are passed as a standard hash.
  config.markdown_options = { input: "GFM", smart_quotes: "apos,quot" }

  # Redcarpet
  # Options are nested under :renderer_options and :markdown_options.
  config.markdown_options = {
    renderer_options: { hard_wrap: true },
    markdown_options: { tables: true, autolink: true }
  }

  # …
end
```


## Custom markdown parser

[!label v0.14.0+]

```ruby
class MyParser < Perron::Markdown::Parser
  def parse(text)
    # Do whatever you want here
    # `config.markdown_options` is available as `options` instance method
  end
end
```

Extend the `Perron::Markdown::Parser` class or any of the three provided markdown providers.

Then use it by setting `markdown_parser`:
```ruby
Perron.configure do |config|
  # …
  config.markdown_parser = :my_parser
  # …
end
```


## HTML transformations

Perron can post-process the markdownified content.


### Usage

Apply transformations by passing an array of processor names or classes to the `markdownify` helper via the `process` option.
```erb
<%= markdownify @resource.content, process: %w[lazy_load_images syntax_highlight target_blank] %>
```


### Available processors

The following processors are built-in and can be activated by passing their string name:

- `target_blank`: Adds `target="_blank"` to all external links;
- `lazy_load_images`: Adds `loading="lazy"` to all `<img>` tags;
- `syntax_highlight`: Applies syntax highlighting to fenced code blocks (e.g., \`\`\`ruby).

> [!note]
> Processors are included as _first-party_ options only when they require no setup or configuration. Otherwise, they are added to the [library](/library/).


### Create your own processor

Create your own processor by defining a class that inherits from `Perron::HtmlProcessor::Base` and implements a `process` method.
```ruby
# app/processors/add_nofollow_processor.rb
class AddNofollowProcessor < Perron::HtmlProcessor::Base
  def process
    @html.css("a[target=_blank]").each { it["rel"] = "nofollow" }
  end
end
```

> [!note]
> The `@html` instance variable is a `Nokogiri::HTML::DocumentFragment` object, that gives access to methods like `css()`, `xpath()` and DOM manipulation. See the [Nokogiri docs](https://nokogiri.org/) for more.

Then, pass the class constant directly in the `process` array.
```erb
<%= markdownify @resource.content, process: ["target_blank", AddNofollowProcessor] %>
```


## Syntax highlighting

For the markdown gems that do not have syntax highlighting support out-of-the-box, enable the `syntax_highlight` processor as described above. This also requires adding the `rouge` gem to the Gemfile (`bundle add rouge`).

For the `syntax_highlight` processor to render colors, add a CSS theme from the `rouge` gem to the application's assets.

1. **Generate the Stylesheet:** Use the `rougify` command-line tool that comes with the gem to create a CSS file. Run the following command in the terminal, replacing `github` with your preferred theme.
```shell
bundle exec rougify style github > app/assets/stylesheets/rouge-theme.css
```

This command takes the `github` theme and saves it as a standard CSS file that Propshaft can serve directly *(to see a list of all available themes, run `bundle exec rougify help style`)*.

2. **Include the Stylesheet:** Add the generated file to the application's layout (e.g., `app/views/layouts/application.html.erb`). The standard Rails helper works perfectly.
```erb
<%= stylesheet_link_tag "rouge-theme", media: "all" %>
```
