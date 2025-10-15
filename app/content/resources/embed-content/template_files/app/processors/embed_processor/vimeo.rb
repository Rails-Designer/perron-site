class EmbedProcessor
  class Vimeo
    def self.matches?(text)
      text.match?(%r{https?://(?:www\.)?vimeo\.com/})
    end

    def self.embed(text, html)
      id = text[%r{vimeo\.com/(\d+)}, 1]

      Nokogiri::XML::Node.new("iframe", html).tap do |iframe|
        iframe["src"] = "https://player.vimeo.com/video/#{id}"
        iframe["width"] = "100%"
        iframe["height"] = "400"
        iframe["allowfullscreen"] = "true"
      end
    end
  end
end
