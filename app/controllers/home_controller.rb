class HomeController < ApplicationController

  def show
    load_neighborhoods
  end

  def mobile
    load_neighborhoods
  end

  private

  def load_neighborhoods
    @neighborhoods = Neighborhood.all
  end

end
