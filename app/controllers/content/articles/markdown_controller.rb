class Content::Articles::MarkdownController < ApplicationController
  layout false

  def show
    @article = Content::Article.find!(params[:id])

    render plain: @article.content
  end
end
