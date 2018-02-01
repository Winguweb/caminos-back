class WorksController < ApplicationController
  include CurrentAndEnsureDependencyLoader

  helper_method :current_neighborhood

  def show
    ensure_neighborhood; return if performed?

    load_work
    @section_header_breadcrumbs = [
      "Home",current_neighborhood.name, "Obras"
    ]
    @section_header_links = [{:title => t('.edit'), :href => edit_neighborhood_work_path}]

  end

  def new
    ensure_neighborhood; return if performed?
    @section_header_breadcrumbs = [
      "Home",
      current_neighborhood.name,
      t(".works")
    ]
    @categories = ["Agua", "Luz", "Drenaje"]
    @documents_list = [
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
    ]
    @documents_list_button = [
      {:title => 'Cargar Documento'},
    ]
    @work = current_neighborhood.works.new
  end

  def create
    ensure_neighborhood; return if performed?

    service = CreateWork.call(current_neighborhood, work_params)

    if service.success?
      redirect_to neighborhood_works_path
    else
      redirect_to  new_neighborhood_work_path(current_neighborhood)
    end
  end

  def index
    ensure_neighborhood; return if performed?

    @works = current_neighborhood.works
  end

  def edit
    ensure_neighborhood; return if performed?
    @section_header_breadcrumbs = [
      "Home",
      current_neighborhood.name,
      t(".works")
    ]
    @categories = ["Agua", "Luz", "Drenaje"]
    @documents_list = [
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
    ]
    @documents_list_button = [
      {:title => 'Cargar Documento'},
    ]
    load_work
  end

  def update
    ensure_neighborhood; return if performed?

    load_work

    service = UpdateWork.call(@work, work_params)

    if service.success?
      redirect_to neighborhood_work_path()
    else
      redirect_to edit_neighborhood_work_path()
    end
  end

  private

  def load_work
    @work = current_neighborhood.works.find(params[:id])
  end

  def work_params
    params.require(:work).permit(
      :budget,
      :description,
      :end_date,
      :estimated_end_date,
      :execution_plan,
      :geometry,
      :geo_geometry,
      :lookup_address,
      :lookup_coordinates,
      :manager,
      :name,
      :status,
      :start_date
    )
  end

end
