class EmbedProcessor
  class Loom
    def self.matches?(text)
      text.match?(%r{https?://(?:www\.)?loom\.com/share/})
    end

    def self.embed(text, html)
      id = text[%r{loom\.com/share/([^\s?]+)}, 1]

      Nokogiri::XML::Node.new("iframe", html).tap do |iframe|
        iframe["src"] = "https://www.loom.com/embed/#{id}"
        iframe["width"] = "100%"
        iframe["height"] = "400"
        iframe["allowfullscreen"] = "true"
        iframe["frameborder"] = "0"
      end
    end
  end
end
