class NeighborhoodsController < ApplicationController
  before_action :check_for_mobile, :only => [:show, :about]

  def show
    load_neighborhood
    @filters = params[:filters].blank? ? nil : params[:filters].split(',')
  end

  def about
    load_neighborhood
    load_meetings
  end

  def agreement
    load_neighborhood
    if !@neighborhood.agreement.blank? && !@neighborhood.agreement.data.nil?
      @data = JSON.parse(@neighborhood.agreement.data)
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
