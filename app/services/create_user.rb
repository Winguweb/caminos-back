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

    data =  @allowed_params
    data.merge!(profile: Profile.new(first_name: @allowed_params[:first_name]),active: true, approved: true, confirmed: true, roles: [:ambassador])
    data.delete(:first_name)
    @user = User.new(data)
    return @user if @user.save
    errors.add_multiple_errors(@user.errors.messages) && nil
  
  end

end
