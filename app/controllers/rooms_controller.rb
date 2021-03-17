class RoomsController < ApplicationController
  before_action :current_date, only: :show
  before_action :load_date_params, only: :show

  def show
    sdate = params[:start_date].to_date
    edate = params[:end_date].to_date
    if current_date > sdate || current_date > edate || sdate > edate
      flash.now[:warning] = t "booked_date_error"
      return @rooms = []

    end
    booked_in_time = Booking.pending.rooms_booked sdate, edate
    @rooms = Room.not_in_ids booked_in_time
  end
end
