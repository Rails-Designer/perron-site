class Content::ArticlesController < ApplicationController
  def index
    @metadata = {
      title: "Documentation",
      description: "TBD"
    }

    @resources = Content::Article.all
  end

  def show
    @resource = Content::Article.find(params[:id])
  end
end
