module Admin
  module UsersHelper
    def is_admin?
      current_user.roles.first == :admin
    end

    def restrict_if_ambassador
      unless is_admin?
        flash[:error] = "No puede realizar esta accion"
        redirect_back fallback_location: root_path
      end
    end
  end
end
