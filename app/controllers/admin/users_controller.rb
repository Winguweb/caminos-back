module Admin
  class UsersController < BaseController

    def show
      load_user
    end

    def new
      @user = User.new(profile: Profile.new)
      @entities = Organization.all + Neighborhood.all
    end

    def create
      service = CreateUser.call(user_params)

      if service.success?
        redirect_to root_path
      else
        redirect_to new_user_path
      end
    end

    def index
      @users = User.preload(:profile).all
    end

    def edit
      load_user
    end

    def update
      load_user

      service = UpdateUser.call(@user, user_params)

      if service.success?
        redirect_to user_path(@user)
      else
        redirect_to edit_user_path(@user)
      end
    end

    def destroy
      load_user

      service = DestroyUser.call(@user)

      if service.success?
        redirect_to root_path
      else
        redirect_to user_path(@user)
      end
    end

    private

    def user_params
      params.require(:user).permit(
        :username,
        :email,
        :password,
        :entity,
        profile: {}
      )
    end

    def load_user
      @user = User.find(params[:id])
    end

  end
end
