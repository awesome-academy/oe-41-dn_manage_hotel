# frozen_string_literal: true

class Admin::RoomsController < Admin::AdminController
  def show
    @room_ids_booked = Booking.room_in_booking
    @temp = Room.rooms_in_booking(@room_ids_booked)
    @rooms = @temp.paginate(page: params[:page]).per_page(Settings.paging_limit)
  end
end
