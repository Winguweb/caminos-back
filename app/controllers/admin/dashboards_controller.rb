module Admin
  class DashboardsController < BaseController
    def show
      @neighborhoods = Neighborhood.all.order(urbanization: :desc, name: :asc)
    end
  end
end
