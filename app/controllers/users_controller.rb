class UsersController < ApplicationController
  # load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @user = current_user

    if @user.update(user_params)
      redirect_to user_path(current_user), notice: 'Профиль обновлен успешно'
    else
      render :edit
    end
  end

  private def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      # :avatar,
      :icq,
      :skype,
      :phone
    )
  end
end
