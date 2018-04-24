class WorksController < ApplicationController
  before_action :check_for_mobile, :only => [:show]

  def show
    load_work
  end

  private

  def load_work
    @work = Work.find(params[:id])
  end

  def load_neighborhood
    @neighborhood = @work.neighborhood
  end

end
