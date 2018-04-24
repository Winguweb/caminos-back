class NeighborhoodsController < ApplicationController
  before_action :check_for_mobile, :only => [:show]

  def show
    load_neighborhood
    @filters = params[:filters].blank? ? nil : params[:filters].split(',')
  end

  def about
    load_neighborhood
  end

  def agreement
    load_neighborhood
    if !@neighborhood.agreement.blank? && !@neighborhood.agreement.data.nil?
      # TODO: ESTO ES PELIGROSO!!!
      @data = eval(@neighborhood.agreement.data)
    else
      @data = {}
    end
  end

  private

  def load_neighborhood
    @neighborhood = Neighborhood.find(params[:id])
  end

  def load_meetings
    @meetings = @neighborhood.meetings.order(date: :desc).group_by { |x| x.date.year }
  end


end
