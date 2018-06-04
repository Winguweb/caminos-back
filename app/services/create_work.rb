class CreateWork
  prepend Service::Base

  def initialize(neighborhood, allowed_params)
    @neighborhood = neighborhood
    @allowed_params = allowed_params
  end

  def call
    create_work
  end

  private

  def create_work
    @work = Work.new(work_params)
    @work.neighborhood = @neighborhood

    return @work if @work.save

    errors.add_multiple_errors(@work.errors.messages) && nil
  end

  def work_params
    {
      budget: @allowed_params[:budget],
      category_list: @allowed_params[:category_list],
      description: @allowed_params[:description],
      estimated_end_date: @allowed_params[:estimated_end_date],
      execution_plan: @allowed_params[:execution_plan],
      geometry: @allowed_params[:geometry],
      geo_geometry: @allowed_params[:geo_geometry],
      lookup_address: @allowed_params[:lookup_address],
      manager: @allowed_params[:manager],
      name: @allowed_params[:name],
      status: @allowed_params[:status],
      start_date: @allowed_params[:start_date],
    }
  end
end
