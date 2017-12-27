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
      render :new
    end
  end

  def index
    @neighborhoods = Neighborhood.all
    meetings_works
  end

  def meetings_works
    @meetings = 0 
    @neighborhoods.each do |neighborhood|
      neighborhood.works.each do |work|
        @meetings += work.meetings.count
      end
    end

  end

  private 

 
  def neighborhood_params
    params.require(:neighborhood).permit(:description, :location, :name, :manager,:ambassador)
  end

  def load_neighborhood
    @neighborhood = Neighborhood.find(params[:id])
  end

end
