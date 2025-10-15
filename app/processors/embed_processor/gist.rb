class EmbedProcessor
  class Gist
    def self.matches?(text)
      text.match?(%r{https?://gist\.github\.com/})
    end

    def self.embed(text, html)
      url = text[%r{https?://gist\.github\.com/[^\s]+}, 0]

      Nokogiri::XML::Node.new("script", html).tap do |script|
        script["src"] = "#{url}.js"
      end
    end
  end
end
