module Admin
  class UsersController < BaseController

    def index
      @users = User.preload(:profile, :entity).all
    end

    def show
      load_user
    end

    def new
      @user = User.new(profile: Profile.new)
      load_neighborhoods
    end

    def create
      service = CreateUser.call(user_params, roles_params)
      if service.success?
        redirect_to root_path
      else
        redirect_to new_admin_user_path
      end
    end

    def edit
      load_user
      load_neighborhoods
      @neighborhood = @user.entity.class.to_s == 'Neighborhood' ? @user.entity.id : nil
    end

    def update
      load_user

      service = UpdateUser.call(@user, user_params, roles_params)

      if service.success?
        redirect_to admin_user_path(@user)
      else
        redirect_to edit_admin_user_path(@user)
      end
    end

    def destroy
      load_user

      service = DestroyUser.call(@user)

      if service.success?
        redirect_to admin_users_path
      else
        redirect_to admin_user_path(@user)
      end
    end

    private

    def user_params
      params.require(:user).permit(
        :username,
        :email,
        :password,
        :neighborhood_id,
        profile: {}
      )
    end

    def roles_params
      params.permit(roles: {})
    end

    def load_user
      @user = User.find(params[:id])
    end

    def load_neighborhoods
      @neighborhoods = Neighborhood.all
    end

  end
end
