class EmbedProcessor
  class Youtube
    def self.matches?(text)
      text.match?(%r{https?://(?:www\.)?(?:youtube\.com/watch\?v=|youtu\.be/)})
    end

    def self.embed(text, html)
      id = text[/(?:v=|youtu\.be\/)([^&?\s]+)/, 1]

      Nokogiri::XML::Node.new("iframe", html).tap do |iframe|
        iframe["src"] = "https://www.youtube.com/embed/#{id}"
        # Use this line to stop YouTube tracking your visitors who don't play the video
        # iframe["src"] = "https://www.youtube-nocookie.com/embed/#{id}"
        iframe["width"] = "100%"
        iframe["height"] = "400"
        iframe["allowfullscreen"] = "true"
      end
    end
  end
end
