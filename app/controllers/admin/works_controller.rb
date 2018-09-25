module Admin
  class WorksController < BaseController
    include CurrentAndEnsureDependencyLoader
    include UsersHelper

    before_action :restrict_if_responsible, only: [:destroy]
    helper_method :current_neighborhood

    def create
      ensure_neighborhood; return if performed?

      service = CreateWork.call(current_neighborhood, work_params)

      if service.success?
        redirect_to admin_neighborhood_works_path
      else
        flash.now[:error] =  load_errors(service.errors)
        @categories = Work.categories
        @status = Work.status
        @work = current_neighborhood.works.new(work_params)
        render action: :new
      end
    end

    def edit
      ensure_neighborhood; return if performed?

      @categories = Work.categories
      @status = Work.status
      load_work
    end

    def index
      ensure_neighborhood; return if performed?

      @works = current_neighborhood.works
    end

    def new
      ensure_neighborhood; return if performed?

      @categories = Work.categories
      @status = Work.status
      @work = current_neighborhood.works.new
    end

    def show
      ensure_neighborhood; return if performed?

      load_work
    end

    def update
      ensure_neighborhood; return if performed?

      load_work
      service = UpdateWork.call(@work, work_params)

      if service.success?
        redirect_to admin_neighborhood_work_path
      else
        flash.now[:error] =  load_errors(service.errors)
        @categories = Work.categories
        @status = Work.status
        @work = current_neighborhood.works.new(work_params)
        render action: :edit
      end
    end

    def destroy
      ensure_neighborhood; return if performed?

      load_work

      if @work.destroy
        redirect_to admin_neighborhood_works_path(current_neighborhood)
      else
        redirect_back(fallback_location: admin_dashboard_path)
      end
    end

    private

    def load_errors(errors)
      messages  = []
      errors.each do |error|
        messages << t('admin.works.errors', field: t("works.#{error}"))
      end
      return messages
    end

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
        :start_date,
        :category_list
      )
    end

  end
end
