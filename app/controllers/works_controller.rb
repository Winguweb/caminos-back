class WorksController < ApplicationController
  include CurrentAndEnsureDependencyLoader
  before_action :check_for_mobile, :only => [:show, :index]
  helper_method :current_meetable

  def show
    load_work
  end

  def index
    load_works
  end

  private

  def load_work
    @work = Work.find(params[:id])
  end

  def load_works
    @works = current_meetable.works
  end

  def current_meetable
    return @current_meetable if defined? @current_meetable

    @current_meetable = current_neighborhood || current_meeting

    (redirect_back(fallback_location: root_path) and return) unless @current_meetable

    @current_meetable
  end

end
