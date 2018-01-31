class NeighborhoodsController < ApplicationController

  def show
    load_neighborhood
    @page_header_links = [
      {:title => t('.information'), :href => '#information'},
      {:title => t('.works'), :href => neighborhood_works_path(@neighborhood)},
      {:title => t('.meetings'), :href => neighborhood_meetings_path(@neighborhood)},
      {:title => t('.agreement'), :href => '#agreement'},
      {:title => t('.activity'), :href => '#activity'},
    ]
    @section_header_breadcrumbs = [
      "Home",
    ]

    @section_header_links = [{:title => t('.edit'), :href => edit_neighborhood_path}]
    @documents_list = [
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
    ]
    @documents_list_button = [
      {:title => 'Cargar Documento'},
    ]
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
    @neighborhoods = Neighborhood.order('name ASC' )
    
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
