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

    load_work
  end

  def update
    ensure_neighborhood; return if performed?

    load_work

    service = UpdateWork.call(@work, work_params)

    if service.success?
      redirect_to neighborhood_work_path(@work)
    else
      redirect_to edit_neighborhood_work_path(@work)
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
