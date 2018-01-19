class NeighborhoodsController < ApplicationController

  def show
    @neighborhood = Neighborhood.find(params[:id])
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
    params.require(:neighborhood).permit(
      :description,
      :geo_polygon,
      :lookup_address,
      :lookup_coordinates,
      :name,
      :polygon
     )
  end
end
