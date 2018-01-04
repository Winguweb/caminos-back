class CreateUser
  prepend Service::Base

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
    @user_params ||= @allowed_params.merge({
      active: true,
      approved: true,
      confirmed: true,
      roles: [ :ambassador ],
      entity_id: @allowed_params['entity'].strip.split(/\s+/)[0],
      entity_type: @allowed_params.delete('entity').strip.split(/\s+/)[1],
      profile: Profile.new( profile_params )
    })
  
  end

  def profile_params
    @profile_params ||= @allowed_params.delete('profile')
  end

end
