module Admin
  class NeighborhoodsController < BaseController
    include UsersHelper
    before_action :restrict_if_responsible, only: [:destroy]
    before_action :restrict_neighborhood

    def show
      load_neighborhood; return if performed?

      @documents = @neighborhood.documents.all
    end

    def new
      @neighborhood = Neighborhood.new
    end

    def create
      service = CreateNeighborhood.call(neighborhood_params)

      if service.success?
        redirect_to admin_neighborhoods_path
      else
        redirect_to new_admin_neighborhood_path
      end
    end

    def edit
      load_neighborhood; return if performed?
    end

    def update
      load_neighborhood; return if performed?

      service = UpdateNeighborhood.call(@neighborhood, neighborhood_params)

      if service.success?
        redirect_to admin_neighborhood_path(@neighborhood)
      else
        redirect_to edit_admin_neighborhood_path(@neighborhood)
      end
    end

    def index
      @neighborhoods = Neighborhood.all.order([{urbanization: :desc}, 'LOWER(name)'])
    end

    def destroy
      load_neighborhood; return if performed?

      if @neighborhood.destroy
        redirect_to admin_dashboard_path
      else
        redirect_back(fallback_location: admin_dashboard_path)
      end
    end

    private

    def load_neighborhood
      return if @neighborhood = Neighborhood.find_by(id: params[:id])

      redirect_back(fallback_location: admin_dashboard_path)
    end

    def neighborhood_params
      params.require(:neighborhood).permit(
        :description,
        :gdrive_folder,
        :geo_geometry,
        :geometry,
        :lookup_address,
        :lookup_coordinates,
        :name,
        :urbanization
       )
    end

    def neighborhood_gdrive_folder_changed?
      @neighborhood.previous_changes[:extras].present? &&
      @neighborhood.previous_changes[:extras].any?{|extra| extra.keys.include?('gdrive_folder') }
    end
  end
end
