class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate params[:session][:password]
      login @user
      redirect_back_or users_path
    else
      flash.now[:warning] = t "email_or_password_not_true"
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
