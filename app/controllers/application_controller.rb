class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "please_log_in"
    redirect_to new_session_path
  end

  def update_status_booked
    bookeds = Booking.not_delete.check_time_create_booked
    bookeds.pending.update_all(status: Booking.statuses[:rejected])
  end

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    return I18n.locale = locale if I18n.available_locales.include?(locale)

    I18n.locale = I18n.default_locale
  end
end
