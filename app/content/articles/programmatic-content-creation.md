---
section: content
order: 6.5
title: Programmatic content
description: Generate hundreds of pages from data sources for programmatic SEO and scalable content creation.
---

[!label v0.14.0+]

Generate content programmatically from [data sources](/docs/data/) instead of creating files manually. Define a template once and Perron creates resources for every combination of the data. Perfect for programmatic SEO where similar pages with different data are needed.


## Basic Usage

First create data resources:
```json
// app/content/data/countries.json
[
  {"id": "de", "name": "Germany"},
  {"id": "nl", "name": "The Netherlands"}
]
```

```csv
# app/content/data/products.csv
id,name,price
1,iPhone,999
2,iPad,799
```

Then define data sources in the content resource class:
```ruby
# app/models/content/product.rb
class Content::Product < Perron::Resource
  sources :countries, :products

  def self.source_template(sources)
    <<~TEMPLATE
    ---
    title: #{sources.products.name} in #{sources.countries.name}
    country_id: #{sources.countries.id}
    product_id: #{sources.products.id}
    ---

    # #{sources.products.name}

    Available in #{sources.countries.name} for $#{sources.products.price}.
    TEMPLATE
  end
end
```

> [!note]
> Use the generator `bin/rails generate content Product --data countries.json products.csv`

Generate resources:
```bash
bin/rails perron:sync_sources
```

This creates four files in `app/content/products/`:
- `de-1.erb`
- `nl-1.erb`
- `de-2.erb`
- `nl-2.erb`

Each file is processed like any regular resource with full access to layouts, helpers and routing.


## Custom primary keys

By default, Perron uses `id` to identify records. Use the `primary_key` option to specify a different column:
```ruby
class Content::Product < Perron::Resource
  sources :countries, products: { primary_key: :code }

  def self.source_template(sources)
    <<~TEMPLATE
    ---
    title: #{sources.products.name}
    country_id: #{sources.countries.id}
    product_code: #{sources.products.code}
    ---
    TEMPLATE
  end
end
```

Filenames use the specified primary keys: `us-iphone-15.erb`


## Single source

Use `source` (singular) for a single data source:
```ruby
class Content::City < Perron::Resource
  source :cities

  def self.source_template(sources)
    <<~TEMPLATE
    ---
    title: #{sources.cities.name}
    city_id: #{sources.cities.id}
    ---
    TEMPLATE
  end
end
```


## Syncing

Sync all source-backed resources:
```bash
bin/rails perron:sync_sources
```

Sync a specific resource:
```bash
bin/rails "perron:sync_sources[products]"
```

> [!tip]
> In zsh, quote the task name: `bin/rails "perron:sync_sources[products]"`

Integrate with in the build process:
```bash
bin/rails perron:sync_sources && bin/rails perron:build
```

Run the sync task whenever data changes to regenerate affected resources.
