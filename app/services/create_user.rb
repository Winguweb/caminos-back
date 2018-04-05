class CreateUser
  prepend Service::Base
  include Service::Support::User

  def initialize(allowed_params, roles_params)
    @allowed_params = allowed_params
    @roles = roles_params[:roles].to_h
  end

  def call
    create_user
  end

  private

  def create_user
    @user = User.new(user_params)
    @user.profile = Profile.new(profile_params)

    return @user if @user.save

    errors.add_multiple_errors(@user.errors.messages) && nil
  end

  def user_params
    {
      username: @allowed_params[:username],
      email: @allowed_params[:email],
      password: @allowed_params[:password],
      active: true,
      approved: true,
      confirmed: true,
      roles: roles(@roles)
    }
  end

  def profile_params
    @allowed_params.delete('profile') || {}
  end

end
