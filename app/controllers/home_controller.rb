class HomeController < ApplicationController

  def show
    load_works
    load_neighborhood
  end

  private

  def load_neighborhood
    @neighborhood = Neighborhood.first
  end

  def load_works
    @works = Work.all
  end

end
