class NeighborhoodsController < ApplicationController

  def show
    load_neighborhood
    load_meetings
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

  def load_meetings
    @meetings = @neighborhood.meetings.order(date: :desc).group_by { |x| x.date.year }
  end


end