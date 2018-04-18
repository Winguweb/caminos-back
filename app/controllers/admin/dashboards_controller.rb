module Admin
  class DashboardsController < BaseController
    def show
      @neighborhoods = Neighborhood.where(:urbanization => true).order(name: :asc)
    end
  end
end
