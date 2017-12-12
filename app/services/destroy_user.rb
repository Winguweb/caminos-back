class DestroyUser 
  prepend Service::Base
 
  def initialize(user)
    @user = user
  end

  def call
    destroy_user
  end

  private

  def destroy_user
    return  @user.destroy
  end

end


