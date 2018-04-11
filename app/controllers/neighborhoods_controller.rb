class NeighborhoodsController < ApplicationController

  def show
    load_neighborhood
  end

  def about
    load_neighborhood
  end

  def agreement
    load_neighborhood
    @data = eval(@neighborhood.agreement.data) if !@neighborhood.agreement.data.nil?

  end

  private

  def load_neighborhood
    @neighborhood = Neighborhood.find(params[:id])
  end


end