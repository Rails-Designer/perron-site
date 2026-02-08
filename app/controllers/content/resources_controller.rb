class Content::ResourcesController < Content::DocsController
  def index
    @metadata = {
      title: "Library",
      description: "Snippets, templates and UI components for your Perron-powered site."
    }

    @resources = Content::Resource.all.order(:type).group_by(&:resource_type)
  end

  def show
    @resource = Content::Resource.find!(params[:id])
  end
end
