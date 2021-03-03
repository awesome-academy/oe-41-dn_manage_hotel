class Admin::AdminController < ApplicationController
  layout "admin-page"

  before_action :require_admin

  def require_admin
    check_admin
  end
end
