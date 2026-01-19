class Content::PagesController < ApplicationController
  def root
    @resource = Content::Page.root

    render html: @resource.content, layout: "application"
  end

  def show
    @resource = Content::Page.find(params[:id])

    render html: @resource.content, layout: "application"
  end
end
