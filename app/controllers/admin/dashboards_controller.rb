module Admin
  class DashboardsController < BaseController
    def show
      @neighborhoods = Neighborhood.where(:urbanization => true).order('LOWER(name)')
    end
  end
end
