class Content::ArticlesController < ApplicationController

  def index
    @resources = Content::Article.all
  end

  def show
    @resource = Content::Article.find(params[:id])
  end
end
