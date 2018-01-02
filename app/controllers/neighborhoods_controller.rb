class NeighborhoodsController < ApplicationController

  def show
    load_neighborhood

  end
  
  def new
    @neighborhood = Neighborhood.new
    @ambassadors = User.all
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
    params[:neighborhood][:ambassadors] ||= []
    params.require(:neighborhood).permit(:description, :location, :name ,  ambassadors: [])
  end

  def load_neighborhood
    @neighborhood = Neighborhood.find(params[:id])
  end

end
