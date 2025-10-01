---
type: snippet
name: Surge deployment configuration for Perron
description: Add a complete deployment script for Surge.sh static site hosting with Perron.
---

This snippet adds a deployment binstub for your Perron-powered static site to [Surge.sh](https://surge.sh). It creates a CNAME file for your domain, install the surge package and a complete deploy binstub that handles the entire workflow: building your site, deploying to Surge.sh, and cleaning up the output directory afterward.
