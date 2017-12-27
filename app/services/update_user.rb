class UpdateUser
  prepend Service::Base

  def initialize(user, allowed_params)
    @user = user
    @allowed_params = allowed_params
  end

  def call
    update_user
  end

  private

  def update_user
    begin
      User.transaction do
        unless profile_params.empty?
          UpdateProfile.call(@user.profile, profile_params, true)
        end

        @user.assign_attributes( user_params )

        @user.save! if @user.changed?
      end
    rescue Service::Error, ActiveRecord::RecordInvalid => e
      return errors.add_multiple_errors( exception_errors(e, @delivery) ) && nil
    end

    @user
  end

  def exception_errors(exception, delivery)
    exception.is_a?(Service::Error) ? exception.service.errors : delivery.errors.messages
  end

  def profile_params
    @profile_params ||= (@allowed_params.delete('profile') || {}).reject{ |_, value| value.blank? }
  end

  def user_params
    @allowed_params.reject{ |_, value| value.blank? }
  end

end


