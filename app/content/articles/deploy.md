---
section: getting_started
order: 3
title: Deploy to production
description: Perron can be deployed as a static site (to platforms like Netlify and statichost.eu) or within your production Rails app.
toc: false
---

Perron can be deployed to any build-based platform, like [Netlify](/library/netlify/) and [statichost.eu](/library/statichost/). It can operate in two modes, configured via `config.mode`. This allows a build to be either a full static site or be integrated pages in a dynamic Rails application.

| **Mode** | `:standalone` (default) | `:integrated` |
| :--- | :--- | :--- |
| **Use Case** | Full static site for hosts like [Netlify](/library/netlify/), [statichost.eu](/library/statichost/), etc. | Add static pages to a live Rails app |
| **Output** | `output/` directory | `public/` directory |
| **Asset Handling** | Via Perron | Via Asset Pipeline |

When in `standalone` mode and you're ready to generate your static site, run:
```bash
RAILS_ENV=production rails perron:build
```

This will create your static site in the configured output directory (`output` by default).

View the [Library](/library/#deployment) for deploy scripts to various platforms.


## Local preview

[!label v0.16.0+]

During development, Perron can serve pre-built static files from your output directory. This allows you to preview exactly what will be deployed.

When an output directory exists (created by running `rails perron:build`), requests are automatically served from the static files. If a static file doesn't exist for a given path, the request passes through to Rails normally.

To preview your built site locally:
```bash
rails perron:build
bin/dev
```

To remove the generated output and return to full dynamic rendering:
```bash
rails perron:clobber
```
