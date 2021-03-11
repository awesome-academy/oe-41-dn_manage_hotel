# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionHelper
  before_action :set_locale

  def log_in user
    session[:user_id] = user.id
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t "please_log_in"
    redirect_to login_path
  end

  def load_date
    @current_date = Time.zone.today
    params[:date_start] ||= Time.zone.today
    params[:date_end] ||= params[:date_start]
  end

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    return I18n.locale = locale if I18n.available_locales.include?(locale)

    I18n.locale = I18n.default_locale
  end
end
