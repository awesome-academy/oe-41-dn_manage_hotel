class BookingsController < ApplicationController
  before_action :logged_user?, only: %i(new create)
  before_action :load_room, only: %i(new create)
  before_action :load_date_params
  before_action :load_booking, only: :update

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
    @bookings = current_user.bookings.not_delete.sort_by_id.user_booking
                            .paginate(page: params[:page])
                            .per_page(Settings.per_page)
    return if @bookings

    flash[:warning] = t "booking_not_found"
    redirect_to rooms_path
  end

  def update
    @booking.cancel!
    flash[:success] = t "manipulation_success"
  rescue StandardError
    flash[:error] = t "manipulation_fails"
  ensure
    redirect_to bookings_path
  end

  private

  def load_room
    @room = Room.find_by id: params[:room_id]
    return if @room

    flash[:warning] = t "room_not_found"
    redirect_to rooms_path
  end

  def load_booking
    @booking = Booking.find_by id: params[:id]
    return if @booking

    flash[:warning] = t "booking_not_found"
    redirect_to bookings_path
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date,
                                    customer_attributes: [:name,
                                      :birthday, :address, :id_card])
          .merge(room_id: params[:room_id])
  end
end
