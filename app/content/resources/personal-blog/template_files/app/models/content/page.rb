class Content::Page < Perron::Resource
  delegate :title, :nav_label, to: :metadata
end
