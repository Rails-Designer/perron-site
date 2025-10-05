class NofollowProcessor < Perron::HtmlProcessor::Base
  def process
    @html.css("a").each do |link|
      href = link["href"]

      next if href.blank? || href.start_with?("/", "#", "mailto:")

      link["rel"] = "nofollow"
    end
  end
end
