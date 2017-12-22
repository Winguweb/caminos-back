class NeighborhoodsController < ApplicationController

  def show;end
  
  def new
    @neighborhood = Neighborhood.new
  end

  def create
  	raise
  end

  def index
    @neighborhoods = Neighborhood.all
  end

  def neighborhood_params
    params.require(:neighborhood).permit(:description, :location, :name, :manager)
  end


end
