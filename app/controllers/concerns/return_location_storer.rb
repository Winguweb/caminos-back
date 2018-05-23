# Internal: Store return to location on session
module ReturnLocationStorer
  extend ActiveSupport::Concern

  included do
    helper_method :store_return_to_location,
                  :redirect_to_attemped_location_or_dashboard
  end

  protected

  def store_return_to_location
    if !logged_in? && request.get? && !request.xhr?
      session[:return_to] = request.url
    end
  end

  def redirect_to_attemped_location_or_dashboard
    if session[:return_to].present?
      return_to = session[:return_to]
      clean_return_to_location
      redirect_to return_to
    else
      redirect_to admin_dashboard_path
    end
  end

  def clean_return_to_location
    session.delete(:return_to) && nil
  end
end
