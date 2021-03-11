# frozen_string_literal: true

class BookingsController < ApplicationController
  before_action :logged_in_user, only: %i(new create)
  before_action :load_room, only: %i(new create)
  before_action :load_date, only: :new

  def new
    @date_end = params[:date_end]
    @date_start = params[:date_start]
    @booking = @current_user.bookings.new
    @booking.build_customer
  end

  def create
    @booking = @current_user.bookings.new booking_params
    @bookings = Booking.check_room_available? @booking.room_id,
                                              @booking.start_date,
                                              @booking.end_date
    if @bookings.blank?
      save @booking
    else
      flash.now[:danger] = t "booking_date_exist"
      render :new
    end
  end

  private

  def load_room
    @room = Room.find_by id: params[:room_id]
    return if @room

    flash[:danger] = t "room_not_found"
    redirect_to static_pages_rooms_path
  end

  def booking_params
    params.require(:booking).permit :start_date, :end_date, :room_id,
                                    customer_attributes:
                                    [:name, :birthday, :address, :id_card]
  end

  def save booking
    if booking.save
      flash[:success] = t "created_success"
      redirect_to static_pages_rooms_path
    else
      flash.now[:danger] = t "created_failed"
      @date_end = params[:booking][:end_date]
      @date_start = params[:booking][:start_date]
      render :new
    end
  end
end
