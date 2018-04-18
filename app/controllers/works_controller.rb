class WorksController < ApplicationController

  def show
    load_work
    load_neighborhood
  end

  private

  def load_work
    @work = Work.find(params[:id])
  end

  def load_neighborhood
    @neighborhood = @work.neighborhood
  end

end