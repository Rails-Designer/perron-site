Perron.configure do |config|
  # config.output = "output"

  config.site_name = "Perron"

  # The build mode for Perron. Can be :standalone or :integrated.
  # config.mode = :standalone

  # In `integrated` mode, the root is skipped by default. Set to `true` to enable.
  # config.include_root = false

  config.default_url_options = {host: "perron.railsdesigner.com", protocol: "https", trailing_slash: true}

  # Set default meta values
  # Examples:
  # - `config.metadata.description = "Put your routine tasks on autopilot"`
  # - `config.metadata.author = "Helptail Team"`

  # Set meta title suffix
  config.metadata.title_suffix = "Perron"
  config.metadata.title_separator = " | "
  config.metadata.author = "Rails Designer"
end
