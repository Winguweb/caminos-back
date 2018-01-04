class NeighborhoodsController < ApplicationController

  def show
    load_neighborhood

  end
  
  def new
    @neighborhood = Neighborhood.new
  end

  def create
    service = CreateNeighborhood.call(neighborhood_params)
    if service.success?
      redirect_to neighborhoods_path
    else
      redirect_to new_neighborhood_path
    end
  end

  def index
    @neighborhoods = Neighborhood.all

  end
  private 

 
  def neighborhood_params
    params.require(:neighborhood).permit(:description, :location, :name)
  end

  def load_neighborhood
    @neighborhood = Neighborhood.find(params[:id])
  end

end
