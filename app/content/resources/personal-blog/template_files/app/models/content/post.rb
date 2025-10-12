class Content::Post < Perron::Resource
  delegate :title, to: :metadata
end
