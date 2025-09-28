---
section: getting_started
order: 1
title: Quickstart
description: Learn how to get started quickly with Perron.
---

Get started quickly with Perron by adding it to your existing Rails app or start a new (static) site.

## To an existing app

Start by adding Perron:
```bash
bundle add perron
```

Then generate the initializer:
```bash
rails generate perron:install
```


This creates an initializer:
```ruby
Perron.configure do |config|
  config.site_name = "Helptail"

  # …
end
```


## Create a new site



Start a new Rails app by saving below template locally and run:

```bash
rails new MyNewSite --minimal -T -O -m ~/Desktop/template.rb
```

```ruby
# ~/Deskop/template.rb
gsub_file "Gemfile", /gem "sqlite3".*$/, ""
gsub_file "Gemfile", /gem "activerecord".*$/, ""

remove_file "config/database.yml"
remove_file "config/credentials.yml.enc"
remove_file "config/master.key"

run "rm -r app/views/pwa"


# Remove PWA-related lines from application layout
gsub_file "app/views/layouts/application.html.erb", /^\s*<meta name="apple-mobile-web-app-capable" content="yes">\n/, ""
gsub_file "app/views/layouts/application.html.erb", /^\s*<meta name="mobile-web-app-capable" content="yes">\n/, ""
gsub_file "app/views/layouts/application.html.erb", /^\s*<%# Enable PWA manifest for installable apps \(make sure to enable in config\/routes\.rb too!\) %>\n/, ""
gsub_file "app/views/layouts/application.html.erb", /^\s*<%#= tag\.link rel: "manifest", href: pwa_manifest_path\(format: :json\) %>\n/, ""


append_to_file ".gitignore", "/output/\n"

gem "perron"

after_bundle do
  rails_command("generate perron:install")
end

remove_file "README.md"

create_file "README.md", <<~MARKDOWN
  # My New Site

  TBD

  ## Development

  \`\`\`bash
  bin/dev
  \`\`\`

  ## Deploy/publish

  \`\`\`bash
  RAILS_ENV=production rails perron:build
  \`\`\`
MARKDOWN
```
