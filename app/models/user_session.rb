class UserSession < Authlogic::Session::Base
  before_save :enable_cookie_signing

  def enable_cookie_signing
    self.sign_cookie = true
  end
end
