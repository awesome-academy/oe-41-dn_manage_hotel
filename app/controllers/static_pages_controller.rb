# frozen_string_literal: true

class StaticPagesController < ApplicationController
  before_action :load_date, only: %i(show_rooms)

  def home; end

  def show_rooms
    date_end = params[:date_end].to_date
    date_start = params[:date_start].to_date
    if date_end >= date_start
      if date_end < @current_date || date_start < @current_date
        alert_message_and_redirect_to_rooms
      end
      search params[:date_start], params[:date_end]
    elsif date_end < date_start
      alert_message_and_redirect_to_rooms
    end
  end

  def gallery; end

  private

  def search start_date, end_date
    booked = Booking.booked start_date, end_date
    temp = Room.rooms booked
    @rooms = temp.paginate(page: params[:page]).per_page(Settings.paging_limit)
  end

  def load_date
    @current_date = Time.zone.today
    params[:date_start] ||= Time.zone.today
    params[:date_end] ||= params[:date_start]
  end

  def alert_message_and_redirect_to_rooms
    flash[:warning] = t "your_date_input_not_true"
    redirect_to static_pages_rooms_path
  end
end
