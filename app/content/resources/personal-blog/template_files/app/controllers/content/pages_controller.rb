class Content::PagesController < ApplicationController
  def root
    # Setting `@resource` is required for the the metadata/meta tags generation
    @resource = Content::Page.root

    render html: @resource.content, layout: "application"
  end

  def show
    @resource = Content::Page.find(params[:id])

    render html: @resource.content, layout: "application"
  end
end
