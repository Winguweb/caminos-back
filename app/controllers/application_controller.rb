class ApplicationController < ActionController::Base
  include SetLocaleAndTimezone

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  around_action :set_time_zone

  layout 'public'
end
