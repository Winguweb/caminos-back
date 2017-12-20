class UpdateUser 
  prepend Service::Base
 
  def initialize(user, allowed_params)
    @allowed_params = allowed_params
    @user = user
  end

  def call
    update_user
  end

  private

  def update_user
    data =get_user_params
    @user.profile.update(get_profile_params)
    return @user if @user.update(data)
    errors.add_multiple_errors(@user.errors.messages) && nil
  
  end


  def get_user_params
  
    permitted_params = ["username", "email", "password"]
    user_params = {}
    @allowed_params.each do |key ,value| 
      user_params[key] = value if  permitted_params.include? key
    end
    user_params.merge!(active: true, approved: true, confirmed: true, roles: [:ambassador])
    
  end

  def get_profile_params

    permitted_params = ["first_name"]
    profile_params = {}
    @allowed_params.each do |key ,value| 
      profile_params[key] = value if  permitted_params.include? key
    end
    return profile_params

  end

end


