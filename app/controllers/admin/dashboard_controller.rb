module Admin
  class DashboardController < ApplicationController
    def show
      @users = User.preload(:profile).all
    end
  end
end
