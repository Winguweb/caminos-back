module Admin
  class DashboardsController < BaseController
    def show
      @users = User.preload(:profile).all
    end
  end
end
