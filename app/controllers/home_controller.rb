class HomeController < ApplicationController

  def show
    @neighborhoods = Neighborhood.where(urbanization: true).order('LOWER(name)')
    @unurbanized= Neighborhood.where(urbanization: false).order('LOWER(name)')
  end

  def mobile
    @neighborhoods = Neighborhood.where(urbanization: true).order('LOWER(name)')
    @unurbanized= Neighborhood.where(urbanization: false).order('LOWER(name)')
  end

  private

end
