class Admin::AdminController < ApplicationController
  layout "admin"
  before_action :logged_user?
  before_action :require_admin?

  def require_admin?
    admin?
  end
end
