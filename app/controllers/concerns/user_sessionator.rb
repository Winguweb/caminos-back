# Internal: Manage user sessions
module UserSessionator
  extend ActiveSupport::Concern

  included do
    helper_method :current_user,
                  :logged_in?
  end

  protected

  def handle_unverified_request
    current_user_session.destroy if current_user_session

    redirect_to signin_path
  end

  # This method is intended to be used on a before_action
  # Examples
  #
  #   before_action :load_new_session
  def load_new_session
    @user_session = UserSession.new unless logged_in?
  end

  def current_user
    return @current_user.presence unless @current_user.nil?

    @current_user = current_user_session ? current_user_session.user : false
    @current_user.profile if @current_user

    @current_user
  end

  def logged_in?
    current_user.present?
  end

  private

  def current_user_session
    return @current_user_session if @current_user_session.present?

    activate_authlogic unless UserSession.activated?

    @current_user_session = UserSession.find
  end

end
