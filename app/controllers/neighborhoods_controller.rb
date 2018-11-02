class NeighborhoodsController < ApplicationController
  before_action :check_for_mobile, only: %i[index show about mapping]

  def index
    @neighborhoods = Neighborhood.order('LOWER(name)')
    @urbanized = @neighborhoods.where(urbanization: true).order('LOWER(name)')
    @unurbanized= @neighborhoods.where(urbanization: false).order('LOWER(name)')
  end

  def show
    load_neighborhood_or_redirect; return if performed?
  end

  def about
    load_neighborhood_or_redirect
    load_meetings
  end

  def agreement
    load_neighborhood_or_redirect
    if !@neighborhood.agreement.blank? && !@neighborhood.agreement.data.nil?
      @data = JSON.parse(@neighborhood.agreement.data)
    else
      @data = {}
    end
  end

  def mapping
    load_neighborhood_or_redirect
  end

  private

  def load_neighborhood_or_redirect
    redirect_to root_path unless @neighborhood = Neighborhood.friendly.find(params[:id])
  end

  def load_meetings
    @meetings = @neighborhood.meetings.order(date: :desc).group_by { |x| x.date.year }
  end

end
