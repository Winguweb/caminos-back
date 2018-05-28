module Admin
  class DashboardsController < BaseController
    include UsersHelper
    before_action :restrict_neighborhood

    def show
      @neighborhoods = Neighborhood.where(:urbanization => true).order('LOWER(name)')
    end
  end
end
