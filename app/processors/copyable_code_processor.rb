class CopyableCodeProcessor < Perron::HtmlProcessor::Base
  include RailsIcons::Helpers::IconHelper

  def process
    @html.css("pre").each do |pre|
      id = "pre_#{Random.hex(4)}"

      wrapper = Nokogiri::XML::Node.new("div", @html)
      wrapper["class"] = "relative group/code"

      button = Nokogiri::XML::Node.new("button", @html)
      button["type"] = "button"
      button["class"] = "absolute inline-block top-0 right-0 mx-3 my-4.5 bg-slate-900/90 text-white/80 cursor-pointer rounded-md transition hover:text-white hover:scale-102 active:scale-98"
      button["data-action"] = "copy"
      button["data-target"] = "##{id}"
      button["data-copy-duration"] = "5000"

      copy_icon = icon("clipboard", class: "size-4 block group-has-[[data-copy-success=true]]/code:hidden")
      success_icon = icon("clipboard-document-check", class: "size-4 hidden group-has-[[data-copy-success=true]]/code:block")

      button.inner_html = [copy_icon, success_icon].join

      pre["id"] = id
      pre.wrap(wrapper)
      pre.add_previous_sibling(button)
    end
  end
end
