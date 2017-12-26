class NeighborhoodsController < ApplicationController

  def show;end
  
  def new
    @neighborhood = Neighborhood.new
  end

  def create
    service = CreateNeighborhood.call(neighborhood_params)
    if service.success?
      redirect_to neighborhoods_path
    else
      render :new
    end
  end

  def index
    @neighborhoods = Neighborhood.all
  end

  def neighborhood_params
    params.require(:neighborhood).permit(:description, :location, :name, :manager,:ambassador)
  end


end
