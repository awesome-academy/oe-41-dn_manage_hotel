class RoomsController < ApplicationController
  before_action :current_date, only: :show
  before_action :load_date_params, only: :show

  def show
    sdate = params[:start_date].to_date
    edate = params[:end_date].to_date
    cur_date = current_date
    if cur_date > sdate || cur_date > edate || sdate > edate
      flash.now[:warning] = t "booked_date_error"
      return @rooms = []

    end
    booked_in_time = Booking.rooms_booked params[:start_date], params[:end_date]
    having_booked_room = Booking.get_room_ids
    @rooms = Room.rooms_can_booking booked_in_time, having_booked_room
  end
end
