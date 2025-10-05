class Content::ResourcesController < Content::DocsController
  def index
    @metadata = {
      title: "Resources",
      description: "Snippets, template and UI components for your Perron-powered site."
    }

    @resources = Content::Resource.all.group_by(&:type)
  end

  def show
    @resource = Content::Resource.find(params[:id])
  end
end
