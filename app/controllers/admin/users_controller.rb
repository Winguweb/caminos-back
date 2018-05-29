module Admin
  class UsersController < BaseController
    include UsersHelper
    before_action :restrict_neighborhood

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

        flash.now[:error] =  load_errors(service.errors)
        @user = User.new(service.reload_user_params)
        @user.profile = Profile.new(user_params[:profile])
        load_neighborhoods
        render action: :new
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
        flash.now[:error] =  load_errors(service.errors)
        load_user
        load_neighborhoods
        render action: :edit
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

    def load_errors(errors)
      messages  = []
      errors.each do |error|
        if error == :password || error == :email
            messages << t(".#{error}", message: errors[error].last)
        else
          messages << t('.errors', field: t(".#{error}"))
        end
      end
      return messages
    end

    def reload_params
      {
        username: user_params[:username],
        email: user_params[:email],
        password: user_params[:password],
        roles: roles(@roles)
      }.tap do |_hash|
        _hash[:entity] = related_entity
      end
    end

  def related_entity
    return Organization.first if roles(@roles)[0] == 'admin'
    @related_entity ||= if id = @allowed_params[:neighborhood_id]
      Neighborhood.find_by(id:id)
    end
  end

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
