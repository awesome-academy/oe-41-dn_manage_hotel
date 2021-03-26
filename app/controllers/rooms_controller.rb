class RoomsController < ApplicationController
  before_action :load_params, only: :index
  before_action :update_status_booked, only: :index

  def index
    rooms_booked = Booking.rooms_booked(params[:start_date], params[:end_date])
                          .not_delete
    @rooms = Room.rooms(rooms_booked)
                 .paginate(page: params[:page])
                 .per_page(Settings.paging_limit)
  end

  private

  def load_params
    params[:start_date] ||= Time.zone.today
    params[:end_date] ||= Time.zone.today
  end
end
