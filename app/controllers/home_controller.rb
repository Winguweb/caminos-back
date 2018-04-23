class HomeController < ApplicationController
  before_action :check_for_mobile, :only => [:show]

  def show
    @neighborhoods = Neighborhood.where(urbanization: true).order('LOWER(name)')
    @unurbanized= Neighborhood.where(urbanization: false).order('LOWER(name)')
  end

  private

end
