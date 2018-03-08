class HomeController < ApplicationController

  def show
    load_neighborhood
  end

  private

  def load_neighborhood
    @neighborhood = Neighborhood.first
  end

end
