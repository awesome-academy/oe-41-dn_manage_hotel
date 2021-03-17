class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate params[:session][:password]
      login @user
      redirect_to root_path
    else
      flash.now[:warnng] = t "email_or_password_not_true"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
