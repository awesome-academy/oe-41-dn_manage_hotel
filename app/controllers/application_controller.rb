class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    return I18n.locale = locale if I18n.available_locales.include?(locale)

    I18n.locale = I18n.default_locale
  end

  def current_date
    @current_date = Time.zone.today
  end

  def logged_user?
    return if logined?

    redirect_to login_path
    flash[:warning] = t "please_log_in"
  end

  def load_date_params
    params[:start_date] ||= current_date
    params[:end_date] ||= current_date
  end
end
