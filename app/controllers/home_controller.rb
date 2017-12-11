class HomeController < ApplicationController

  def show
    @users = User.all
  end

  def new_user

  end

  def create_user
    data = verification_params
    data.merge!(profile: Profile.new(first_name:user_params[:first_name]),active: true, approved: true, confirmed: true, roles: [:ambassador])
    data.delete(:first_name)
    @user = User.new(data)
    if @user.save
      redirect_to root_path
    else
      render :new_user
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :first_name)
  end
end
