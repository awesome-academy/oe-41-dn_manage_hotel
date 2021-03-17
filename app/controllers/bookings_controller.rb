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
    sdate = params[:booking][:start_date]
    edate = params[:booking][:end_date]
    @bookings = Booking.check_can_book sdate, edate, @room
    return save_booking if @bookings.blank?

    flash.now[:warning] = t "booked_date_error"
    render :new
  end

  private

  def load_room
    @room = Room.find_by id: params[:room_id]
    return if @room.present?

    redirect_to rooms_path
    flash[:warning] = t "room_not_found"
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :room_id,
                                    customer_attributes: [:name,
                                      :birthday, :address, :id_card])
  end

  def save_booking
    if @booking.save
      redirect_to rooms_path
      flash[:success] = t "booking_success"
    else
      render :new
    end
  end
end
