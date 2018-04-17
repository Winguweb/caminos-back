class HomeController < ApplicationController

  def show
    @neighborhoods = Neighborhood.where(urbanization: true).order(name: :asc)
    @unurbanized= Neighborhood.where(urbanization: false).order(name: :asc)
  end

  private

end
