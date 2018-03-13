class HomeController < ApplicationController

  def show
    load_works
    load_neighborhood
    @neighborhoods = Neighborhood.all
    
  end

  private

  def load_neighborhood
    @neighborhood = Neighborhood.first
    if params[:neighborhood].present? && Neighborhood.exists?(id: params[:neighborhood])
        @neighborhood = Neighborhood.find(params[:neighborhood])
    end
  end

  def load_works
    @works = Work.all
    if params[:neighborhood].present? && Neighborhood.exists?(id: params[:neighborhood])
        @works = Neighborhood.find(params[:neighborhood]).works
    end
  end

end
