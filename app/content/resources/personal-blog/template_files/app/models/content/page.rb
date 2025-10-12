class Content::Page < Perron::Resource
  delegate :title, :nav_included, to: :metadata
end
