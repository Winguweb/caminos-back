class UsersController < ApplicationController

  def show
    load_user
  end

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

  def edit
    load_user
  end

  def update 
    load_user
    service = UpdateUser.call(@user,user_params)
    if service.success?
      redirect_to @user
    else
      render :edit 
    end
  end

  def destroy
    load_user
    service = DestroyUser.call(@user)
    if service.success?
      redirect_to root_path
    else
      redirect_to @user
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :first_name)
  end

  def load_user
    @user = User.find(params[:id])
  end

  
end
