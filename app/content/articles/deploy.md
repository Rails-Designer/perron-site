---
section: getting_started
order: 3
title: Deploy to production
description: Perron can be deployed as a static site (to platforms like Netlify) or within your production Rails app.
---

Perron can be deployed to any build-based platform, like Netlify.

Perron can operate in two modes, configured via `config.mode`. This allows a build to be either a full static site or be integrated pages in a dynamic Rails application.

| **Mode** | `:standalone` (default) | `:integrated` |
| :--- | :--- | :--- |
| **Use Case** | Full static site for hosts like Netlify, Render, etc. | Add static pages to a live Rails app |
| **Output** | `output/` directory | `public/` directory |
| **Asset Handling** | Via Perron | Via Asset Pipeline |

When in `standalone` mode and you're ready to generate your static site, run:
```bash
RAILS_ENV=production rails perron:build
```

This will create your static site in the configured output directory (`output` by default).

View the [resources](/resources/) for deploy scripts to various platforms.
