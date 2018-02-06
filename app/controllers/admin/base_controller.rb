module Admin
  class BaseController < ApplicationController
    include UserSessionator
    include ReturnLocationStorer

    before_action :login_required

    layout 'admin'

    protected

    def login_required(page_params = {})
      return if logged_in?

      store_return_to_location

      redirect_to admin_signin_path(page_params)
    end
  end
end
