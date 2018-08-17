class HomeController < ApplicationController
  before_action :check_for_mobile, :only => [:show]

  def show
    @neighborhoods = Neighborhood.order('LOWER(name)')
    @urbanized = @neighborhoods.where(urbanization: true).order('LOWER(name)')
    @unurbanized= @neighborhoods.where(urbanization: false).order('LOWER(name)')
  end

end
