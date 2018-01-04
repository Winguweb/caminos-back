class WorksController < ApplicationController

  def show
    load_work
  end
  
  def new
    @work = Work.new
  end

  def create
    load_neighborhood
    service = CreateWork.call(work_params,@neighborhood)
    if service.success?
      redirect_to neighborhood_works_path
    else
      redirect_to  new_neighborhood_work_path(@neighborhood)
    end
  end

  def index
    load_neighborhood
    @works = @neighborhood.works
  end
 
  private 
 
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

  def load_work
    @work = Work.find(params[:id])
  end

  def load_neighborhood
    @neighborhood = Neighborhood.find(params[:neighborhood_id])
  end

end
