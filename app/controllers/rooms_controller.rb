class RoomsController < ApplicationController
  before_action :current_date, only: :show
  before_action :load_date_params, only: :show

  def show
    sdate = params[:start_date].to_date
    edate = params[:end_date].to_date
    if current_date > sdate || sdate > edate
      flash[:warning] = t "booked_date_error"
      redirect_to rooms_path
    end
    booked_in_time = booking_at sdate, edate
    @rooms = Room.not_in_ids(booked_in_time)
                 .sort_by_price
                 .paginate(page: params[:page], per_page: Settings.limit_page)
  end

  private

  def booking_at sdate, edate
    Booking.get_room_ids.rooms_booked sdate, edate
  end
end
