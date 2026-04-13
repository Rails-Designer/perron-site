class Content::ShowcasesController < ApplicationController
  def index
    @resources = Content::Showcase.all
  end
end
