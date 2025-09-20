class Content::Article < Perron::Resource
  configure do |config|
    config.metadata.type = "article"
  end
end
