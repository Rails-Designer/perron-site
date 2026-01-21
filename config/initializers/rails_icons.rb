RailsIcons.configure do |config|
  config.default_library = "phosphor"
  config.default_variant = "regular" # Set a default variant for all libraries

  config.libraries.phosphor.exclude_variants = %w[bold fill light thin]

  # config.libraries.phosphor.duotone.default.css = "size-6"
  # config.libraries.phosphor.duotone.default.data = {}

  # config.libraries.phosphor.regular.default.css = "size-6"
  # config.libraries.phosphor.regular.default.data = {}
end
