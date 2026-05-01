class Content::LlmsController < ApplicationController
  layout false

  def index
    articles = Content::Article.all.sort_by { [Content::Article::SECTIONS.keys.index(it.section), it.position] }

    render plain: "# Perron\n\n" + articles.map(&:content).join("\n\n")
  end
end
