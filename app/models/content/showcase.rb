class Content::Showcase < Perron::Resource
  delegate :title, :description, :image, :url, to: :metadata
end
