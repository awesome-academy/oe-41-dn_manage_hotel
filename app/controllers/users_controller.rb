class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t("created_success")
      log_in @user
      redirect_back_or root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation,
                                 :address, :id_card,
                                 :birthday
  end
end
