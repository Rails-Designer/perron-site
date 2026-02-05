---
section: getting_started
order: 1
title: Schnellstart-Anleitung
description: Lernen Sie, wie Sie schnell mit Perron beginnen können.
---

Starten Sie schnell mit Perron, indem Sie es zu Ihrer bestehenden Rails-App hinzufügen oder eine neue statische Website erstellen.

## Haben Sie bereits eine Rails-App?

Beginnen Sie mit dem Hinzufügen von Perron:
```bash
bundle add perron
```

Dann generieren Sie den Initializer:
```bash
rails generate perron:install
```

Dies erstellt einen Initializer:
```ruby
Perron.configure do |config|
  config.site_name = "Chirp Form"

  # …
end
```
