module Admin
  class DashboardsController < BaseController
    def show
      @neighborhoods = Neighborhood.all
    end
  end
end
