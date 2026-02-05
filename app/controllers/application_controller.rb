class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    I18n.locale = params[:locale] || :en
  end

  def default_url_options
    params[:locale] ? { locale: params[:locale] } : {}
  end
end
