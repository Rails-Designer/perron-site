module Content::Article::Adjacency
  extend ActiveSupport::Concern

  def next
    return if current_position&.>= ordered_articles.size - 1

    ordered_articles[current_position + 1]
  end

  def previous
    return unless current_position&.positive?

    ordered_articles[current_position - 1]
  end

  private

  def current_position = ordered_articles.find_index { it.id == id }

  def ordered_articles
    Content::Article.all.sort_by { [ Content::Article::SECTIONS.keys.index(it.section), it.order ] }
  end
end
