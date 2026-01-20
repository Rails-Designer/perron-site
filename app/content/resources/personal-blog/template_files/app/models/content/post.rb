class Content::Post < Perron::Resource
  configure do |config|
    config.feeds.rss.enabled = true
    # config.feeds.rss.title = "My RSS feed" # defaults to configured site_name
    # config.feeds.rss.description = "My RSS feed description" # defaults to configured site_description
  end

  delegate :title, to: :metadata
end
