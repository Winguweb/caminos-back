module Admin
  class UserSessionsController < ApplicationController
    include UserSessionator
    include ReturnLocationStorer

    layout 'admin'

    def new
      redirect_to root_path and return if current_user.present?

      @user_session = UserSession.new
    end

    def create
      @user_session = UserSession.new(user_session_params)

      if @user_session.save
        redirect_to_attemped_location_or_root
      else
        flash[:error] = I18n.t('signin.error')
        flash.keep
        redirect_to admin_signin_path
      end
    end

    def destroy
      current_user_session.destroy
      redirect_to admin_signin_path
    end

    private

    def user_session_params
      params.require(:user_session).permit(:email, :password)
    end

  end
end
