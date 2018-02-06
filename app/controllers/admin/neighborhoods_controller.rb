module Admin
  class NeighborhoodsController < BaseController

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

    def edit
      load_neighborhood
    end

    def update
      load_neighborhood

      service = UpdateNeighborhood.call(@neighborhood, neighborhood_params)

      if service.success?
        redirect_to neighborhood_path(@neighborhood)
      else
        redirect_to edit_neighborhood_path(@neighborhood)
      end
    end

    def index
      @neighborhoods = Neighborhood.all
    end

    private

    def load_neighborhood
      @neighborhood = Neighborhood.find(params[:id])
    end

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
end
