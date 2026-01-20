class Content::Page < Perron::Resource
  def inline(layout: "application", **options)
    { html: content, layout: layout }.merge(options)
  end

  delegate :title, :nav_label, to: :metadata
end
