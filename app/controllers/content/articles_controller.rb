class Content::ArticlesController < Content::DocsController
  def index
    @metadata = {
      title: "Documentation",
      description: "Get started and learn about all the features of Perron."
    }

    @resources = Content::Article.all
  end

  def show
    @resource = Content::Article.find(params[:id])
  end
end
