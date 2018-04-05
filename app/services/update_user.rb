class UpdateUser
  prepend Service::Base
  include Service::Support::User

  def initialize(user, allowed_params, roles_params)
    @user = user
    @allowed_params = allowed_params.to_h
    @roles = roles_params[:roles].to_h
  end

  def call
    update_user
  end

  private

  def update_user
    unless profile_params.empty?
      profile_service = UpdateProfile.call(@user.profile, profile_params)

      return (errors.add_multiple_errors(profile_service.errors) && nil) unless profile_service.success?
    end

    @user.assign_attributes( user_params )

    return @user if !@user.changed? || @user.save

    errors.add_multiple_errors(@user.errors.messages) && nil
  end

  def profile_params
    @profile_params ||= (@allowed_params.delete('profile') || {}).reject{ |_, value| value.blank? }
  end

  def user_params
    @allowed_params.reject{ |_, value| value.blank? }.merge(roles: roles(@roles))
  end

end


