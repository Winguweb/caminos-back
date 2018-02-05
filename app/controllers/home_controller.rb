class HomeController < ApplicationController

  def show
    @neighborhoods = Neighborhood.all
  end
end
