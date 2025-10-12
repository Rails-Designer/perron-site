class Content::ResourcesController < Content::DocsController
  def index
    @metadata = {
      title: "Resources",
      description: "Snippets, template and UI components for your Perron-powered site."
    }

    @resources = Content::Resource.all.sort_by(&:type).group_by(&:resource_type)
  end

  def show
    @resource = Content::Resource.find(params[:id])
  end
end
