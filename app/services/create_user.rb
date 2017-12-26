class CreateUser 
  prepend Service::Base

  USER_PARAMS = %w(username email password).freeze
  private_constant :USER_PARAMS
  PROFILE_PARAMS = %w(first_name last_name).freeze
  private_constant :PROFILE_PARAMS
 
  def initialize(allowed_params)
    @allowed_params = allowed_params

  end

  def call
    create_user
  end

  private

  def create_user

    @user = User.new(user_params)
    return @user if @user.save
    errors.add_multiple_errors(@user.errors.messages) && nil
  
  end

  def user_params
    @allowed_params.select do |key, value|
    USER_PARAMS.include?(key.to_s)
    end.merge({
      active: true, 
      approved: true, 
      confirmed: true,
      roles: [ :ambassador ],
      profile: Profile.new( profile_params )
    })
  end

  def profile_params
    @allowed_params.select do |key, value|
      PROFILE_PARAMS.include?(key.to_s)
    end
  end

end
