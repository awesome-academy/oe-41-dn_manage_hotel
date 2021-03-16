class RoomsController < ApplicationController
  def index
    params[:start_date] ||= Time.zone.today
    params[:end_date] ||= Time.zone.today
    @rooms = Room.rooms
                 .paginate(page: params[:page])
                 .per_page(Settings.paging_limit)
  end
end
