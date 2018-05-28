module Admin
  module UsersHelper

    def is_admin?
      current_user.roles.first == :admin
    end

    def is_responsible_for?
      params[:id] == current_user.entity.id
    end

    def restrict_if_responsible
      unless is_admin?
        flash[:error] = "No puede realizar esta accion"
        redirect_back fallback_location: root_path
      end
    end

    def restrict_neighborhood
      return if is_admin?
      unless is_responsible_for?
        redirect_to admin_neighborhood_path(current_user.entity)
      end
    end
  end
end
