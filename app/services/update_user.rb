class UpdateUser 
  prepend Service::Base
 
  USER_PARAMS = %w(username email password).freeze
  private_constant :USER_PARAMS
  PROFILE_PARAMS = %w(first_name last_name).freeze
  private_constant :PROFILE_PARAMS

  def initialize(user, allowed_params)
    @allowed_params = allowed_params
    @user = user
  end

  def call
    update_user
  end

  private

  def update_user
    @user.profile.update(profile_params) if  @allowed_params[:first_name] != @user.name
    return @user if @user.update(user_params)
    errors.add_multiple_errors(@user.errors.messages) && nil
  
  end

  def user_params
    @allowed_params.select do |key, value|
    USER_PARAMS.include?(key.to_s)
    end.merge({
      active: true, 
      approved: true, 
      confirmed: true,
      roles: [ :ambassador ]
    })
  end

  def profile_params
    @allowed_params.select do |key, value|
      PROFILE_PARAMS.include?(key.to_s)
    end
  end

end


