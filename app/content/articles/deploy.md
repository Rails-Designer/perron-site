---
section: getting_started
order: 3
title: Deploy to production
description: Perron can be deployed as a static site (to platforms like Netlify and statichost.eu) or used within your Rails app.
toc: false
---

Perron can operate in two modes, configured via `config.mode`. This allows a build to be either a full static site or be integrated pages in a dynamic Rails application.

**Full static sites** (`standalone` mode) can be deployed to any build-based platform, like [Netlify](/library/netlify/) and [statichost.eu](/library/statichost/).

**Integrated sites** (`integrated` mode) work within a typical Rails application and can be deployed to any Rails host like Heroku or using Kamal.

| **Mode** | `standalone` (default) | `integrated` |
| :--- | :--- | :--- |
| **Use Case** | Full static site | Add static pages to a live Rails app |
| **Deployment** | Build-based platforms (Netlify, S3, statichost.eu, etc.) | Traditional Rails hosts (Heroku, Kamal, etc.) |
| **Output** | `output/` directory | `public/` directory |
| **Asset Handling** | Via Perron | Via Asset Pipeline |

When in `standalone` mode and ready to generate your static site, run:
```bash
RAILS_ENV=production bundle install && rails perron:build
```

This will create static HTML files in the configured output directory (`output` by default).

View the [Library](/library/#deployment) for deploy scripts to various platforms.


## Local preview

[!label v0.16.0+]

Perron can serve pre-built static files from the output directory. This allows to preview exactly what will be deployed.

When an output directory exists (created by running `rails perron:build`), requests are automatically served from the static files. If a static file doesn't exist for a given path, the request passes through to Rails normally.

To preview the built site locally:
```bash
rails perron:build && bin/dev
```

To remove the generated output and return to full dynamic rendering:
```bash
rails perron:clobber
```
