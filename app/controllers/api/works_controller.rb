module Api
  class WorksController < BaseController
    include CurrentAndEnsureDependencyLoader
    helper_method :current_neighborhood

    def index
      ensure_neighborhood; return if performed?
      status = params[:status]
      unordered_works = current_neighborhood.works
      works = sort_by_status(unordered_works, all: true)
      categories = Work.categories
      render :json => {works: sort_by_status(unordered_works, all: true), categories: categories}
    end

    def by_status
      ensure_neighborhood; return if performed?
      status = params[:status]
      unordered_works = current_neighborhood.works.where(:status => status)
      works = sort_by_status(unordered_works)
      categories = works.keys
      render :json => {works: sort_by_status(unordered_works), categories: categories}
    end

    private

    def sort_by_status(unordered_works, all=false)
      works = {}
      Work.categories.each do |category|
        ordered_works = unordered_works.select do |work|
          work.category.name == category
        end
        works[category] = ordered_works if !ordered_works.empty? || all
      end
      works
    end
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
