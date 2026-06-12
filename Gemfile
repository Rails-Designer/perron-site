source "https://rubygems.org"
git_source(:rd) { "https://github.com/Rails-Designer/#{it}" }

gem "activeresource", "~> 6.2"
gem 'commonmarker', '~> 2.8.2'
gem "importmap-rails", "~> 2.2.3"
gem "perron", rd: "perron"
gem "propshaft", "~> 1.3.1"
gem 'puma', '~> 8.0.1'
gem "rails", "~> 8.1.2"

gem "rails_icons", rd: "rails_icons"
gem "icons", rd: "icons"  # TODO; can be removed from rails_icons 1.9.0

gem "tailwindcss-rails", "~> 4.4.0"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "rubocop-rails-omakase", require: false
end
