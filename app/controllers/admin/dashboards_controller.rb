module Admin
  class DashboardsController < ApplicationController
    def show
      @users = User.preload(:profile).all
    end
  end
end
