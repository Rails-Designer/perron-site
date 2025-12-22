---
section: content
order: 6.5
title: Programmatic content
description: Generate hundreds of pages from data sources for programmatic SEO and scalable content creation.
---

[!label v0.14.0+]

Generate content programmatically from [data sources](/docs/data/) instead of creating files manually. Define a template once and Perron creates resources for every combination of your data. Perfect for programmatic SEO where you need similar pages with different data.


## Basic Usage

First create your data files:
```csv
# app/content/data/products.csv
id,name,price
1,iPhone,999
2,iPad,799
```

```json
// app/content/data/countries.json
[
  {"id": "de", "name": "Germany"},
  {"id": "nl", "name": "The Netherlands"}
]
```

Then define data sources in your resource class:
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

Generate resources:
```bash
bin/rails perron:sync_sources
```

This creates four files in `app/content/products/`:
- `1-de.erb`
- `1-nl.erb`
- `2-de.erb`
- `2-nl.erb`

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

Integrate with your build process:
```bash
bin/rails perron:sync_sources && bin/rails perron:build
```

Run the sync task whenever your data changes to regenerate affected resources.
