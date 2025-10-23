class EmbedProcessor
  class Codepen
    def self.matches?(text)
      text.match?(%r{https?://codepen\.io/})
    end

    def self.embed(text, html)
      # extracts username/pen_id from URLs like `https://codepen.io/railsdesigner/pen/PwZJqqb`
      username, id = text.match(%r{codepen\.io/([^/]+)/pen/([^\s?]+)}).captures

      Nokogiri::XML::Node.new("iframe", html).tap do |iframe|
        iframe["src"] = "https://codepen.io/#{username}/embed/#{id}?default-tab=result"
        iframe["width"] = "100%"
        iframe["height"] = "500"
        iframe["allowfullscreen"] = "true"
      end
    end
  end
end
