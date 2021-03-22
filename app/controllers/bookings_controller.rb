class BookingsController < ApplicationController
  before_action :logged_in_user, only: %i(new create index)
  before_action :load_room, only: %i(new create)
  before_action :load_booked, only: %i(cancel_booked)
  before_action :update_status_booked, only: :index

  def new
    @date_end = params[:end_date]
    @date_start = params[:start_date]
    @booking = @current_user.bookings.new
    @booking.build_customer
  end

  def create
    @booking = @current_user.bookings.new booking_params
    if @booking.save
      flash[:success] = t "created_success"
      redirect_to rooms_path
    else
      flash.now[:danger] = t "created_failed"
      @date_end = params[:booking][:end_date]
      @date_start = params[:booking][:start_date]
      render :new
    end
  end

  def index
    @user_bookeds = @current_user.bookings.not_delete
                                 .user_bookeds.sort_by_created
                                 .paginate(page: params[:page])
                                 .per_page(Settings.paging_limit)
    params[:page] ||= 1
    @index = (params[:page].to_i - 1) * Settings.paging_limit
  end

  def cancel_booked
    @booked.cancel!
    flash[:success] = t "cancel_success"
  rescue StandardError
    flash[:error] = t "cancel_fail"
  ensure
    redirect_to user_bookings_path(user_id: current_user.id)
  end

  private

  def load_room
    @room = Room.find_by id: params[:room_id]
    return if @room

    flash[:danger] = t "room_not_found"
    redirect_to rooms_path
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date,
                                    customer_attributes:
                                    [:name, :birthday, :address, :id_card])
          .merge(room_id: params[:room_id])
  end

  def load_booked
    return if @booked = Booking.find_by(id: params[:id])

    flash[:error] = t("not_found_booked")
    redirect_to user_bookings_path(user_id: current_user.id)
  end
end
