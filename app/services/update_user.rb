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
    data = @allowed_params 
    @user.profile.update(first_name: @allowed_params [:first_name])
    data.delete(:first_name)
    return @user if @user.update(data)
    errors.add_multiple_errors(@user.errors.messages) && nil
  
  end

end


