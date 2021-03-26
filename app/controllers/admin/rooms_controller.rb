class Admin::RoomsController < Admin::AdminController
  def index
    @rooms = Room.not_delete.paginate(page: params[:page])
                 .per_page(Settings.paging_limit)
    params[:page] ||= 1
    @index = (params[:page].to_i - 1) * Settings.paging_limit
  end
end
