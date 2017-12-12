class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show;end

  def new
    @user = User.new
    @user.profile = Profile.new
  end

  def create
    service = CreateUser.call(user_params)
    if service.success?
      redirect_to root_path
    else
      render :new
    end
  end

  def edit;end

  def update 
    service = UpdateUser.call(@user,user_params)
    if service
      redirect_to @user
    else
      render :edit 
    end

  end

  def destroy
    DestroyUser.call(@user)
    redirect_to root_path
  end


  def user_params
    params.require(:user).permit(:username, :email, :password, :first_name)
  end

  def set_user
    @user = User.find(params[:id])
  end

  
end
