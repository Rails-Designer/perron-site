class CopyableCodeProcessor < Perron::HtmlProcessor::Base
  include RailsIcons::Helpers::IconHelper

  def process
    @html.css("pre").each do |pre|
      next if skippable? pre

      id = "pre_#{Random.hex(4)}"

      wrapper = Nokogiri::XML::Node.new("div", @html)
      wrapper["data-slot"] = "code"
      wrapper["class"] = "relative group/code"

      button = Nokogiri::XML::Node.new("button", @html)
      button["type"] = "button"
      button["class"] = "absolute inline-block top-0 right-0 py-2 pr-2 my-1.5 pl-1 bg-slate-900/50 text-white/80 cursor-pointer backdrop-blur-sm transition hover:text-white md:my-3 sm:pr-3 sm:py-2"
      button["data-action"] = "copy"
      button["data-target"] = "##{id}"
      button["data-copy-duration"] = "5000"

      button.inner_html = [ copy_icon, success_icon ].join

      pre["id"] = id
      pre["class"] = "!pr-8"
      pre.wrap wrapper
      pre.add_previous_sibling button
    end
  end

  private

  def skippable?(pre)
    [ "shell-session", "console" ].include? pre["lang"]
  end

  def copy_icon = icon("clipboard", class: "size-3 sm:size-4 block group-has-[[data-copy-success=true]]/code:hidden group-hover/code:scale-105 group-active/code:scale-95")

  def success_icon = icon("clipboard-document-check", class: "size-3 sm:size-4 hidden group-has-[[data-copy-success=true]]/code:block group-hover/code:scale-105 group-active/code:scale-95")
end
