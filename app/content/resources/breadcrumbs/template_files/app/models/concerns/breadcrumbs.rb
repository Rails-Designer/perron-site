module Breadcrumbs
  extend ActiveSupport::Concern

  included do
    helper_method :breadcrumbs
  end

  def breadcrumbs = @breadcrumbs ||= []

  def set_breadcrumbs(*crumbs)
    @breadcrumbs = crumbs.map do |crumb|
      case crumb
      in [ String => name, path ] then Breadcrumb.new(name, path)
      in [ String => name ] then Breadcrumb.new(name)
      in Breadcrumb then crumb
      end
    end
  end

  private

  class Breadcrumb
    attr_reader :name, :path

    def initialize(name, path = nil)
      @name, @path = name, path
    end

    def link? = @path.present?
  end
end
