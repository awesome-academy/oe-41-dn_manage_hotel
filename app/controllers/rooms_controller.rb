class RoomsController < ApplicationController
  before_action :current_date, only: :show

  def show
    params[:start_date] ||= @current_date
    params[:end_date] ||= @current_date
    booked_in_time = Booking.rooms_booked params[:start_date], params[:end_date]
    having_booked_room = Booking.get_room_ids
    @rooms = Room.rooms_can_booking booked_in_time, having_booked_room
  end
end
