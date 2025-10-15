class EmbedProcessor < Perron::HtmlProcessor::Base
  def process
    @html.css("p").each do |paragraph|
      text = paragraph.text
      provider = PROVIDERS.find { it.constantize.matches?(text) } if text.present?

      paragraph.replace(provider.constantize.embed(text, @html)) if provider
    end
  end

  private

  PROVIDERS = %w[
    EmbedProcessor::Codepen
    EmbedProcessor::Gist
    EmbedProcessor::Loom
    EmbedProcessor::Vimeo
    EmbedProcessor::Youtube
  ]
end
