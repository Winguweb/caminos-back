class ApplicationController < ActionController::Base
  include SetLocaleAndTimezone
  include UserSessionator
  include ReturnLocationStorer

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale
  before_action :login_required

  around_action :set_time_zone

  protected

  def login_required(page_params = {})
    return if logged_in?

    store_return_to_location

    redirect_to signin_path(page_params)
  end
end
