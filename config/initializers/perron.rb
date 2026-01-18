Perron.configure do |config|
  config.site_name = "Perron"

  # Set meta title suffix
  config.metadata.title_suffix = "Perron"
  config.metadata.title_separator = " | "
  config.metadata.author = "Rails Designer"

  config.markdown_options = {
    options: {
      render: {
        unsafe: true
      }
    },

    plugins: {
      syntax_highlighter: {
        theme: "tailwind-slate-dark",
        path: Rails.root.join("app", "themes").to_s
      }
    }
  }
end
