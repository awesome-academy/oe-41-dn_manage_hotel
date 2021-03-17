class BookingsController < ApplicationController
  before_action :logged_user?, only: %i(new create)
  before_action :load_room, only: %i(new create)
  before_action :load_date_params

  def new
    @booking = current_user.bookings.new
    @booking.build_customer
  end

  def create
    @booking = current_user.bookings.new booking_params
    if @booking.save
      redirect_to bookings_path
      flash[:success] = t "booking_success"
    else
      flash.now[:warning] = t "booked_date_error"
      render :new
    end
  end

  def index
    temp = Booking.not_delete.sort_by_id.user_booking
    @bookings = temp.paginate(page: params[:page], per_page: Settings.per_page)
    return if @bookings

    flash[:warning] = t "booking_not_found"
    redirect_to rooms_path
  end

  private

  def load_room
    @room = Room.find_by id: params[:room_id]
    return if @room.present?

    redirect_to rooms_path
    flash[:warning] = t "room_not_found"
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date,
                                    customer_attributes: [:name,
                                      :birthday, :address, :id_card])
          .merge(room_id: params[:room_id])
  end
end
