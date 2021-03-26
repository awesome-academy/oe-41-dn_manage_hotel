class Admin::RoomsController < Admin::AdminController
  def index
    params[:page] ||= 1
    @count = (params[:page].to_i - 1) * Settings.per_page
    @rooms = Room.includes(:room_type)
                 .sort_by_price
                 .paginate(page: params[:page], per_page: Settings.per_page)
  end
end
