class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  
  def new
    @user = User.new
    @user.profile = Profile.new
  end

  def create
    
    data = user_params
    data.merge!(profile: Profile.new(first_name:user_params[:first_name]),active: true, approved: true, confirmed: true, roles: [:ambassador])
    data.delete(:first_name)
    @user = User.new(data)
    if @user.save
      redirect_to root_path
    else
      render :new
    end

  end

  def edit
  end

  def update
    data = user_params
    @user.profile.update(first_name: user_params[:first_name])
    data.delete(:first_name)
    if @user.update(data)
      redirect_to @user
    else
      render :edit 
    end

  end

  def destroy
    @user.destroy
    redirect_to root_path
  end


  def user_params
    params.require(:user).permit(:username, :email, :password, :first_name)
  end

  def set_user
    @user = User.find(params[:id])
  end

  
end
