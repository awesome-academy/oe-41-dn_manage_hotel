# frozen_string_literal: true

class SessionController < ApplicationController
  def login; end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate params[:session][:password]
      log_in @user
      redirect_to root_path
    else
      flash.now[:danger] = t "not_valid_email_or_password"
      render :login
    end
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
