class NeighborhoodsController < ApplicationController
  before_action :check_for_mobile, only: %i[index show about mapping]

  def index
    @neighborhoods = Neighborhood.order('LOWER(name)')
  end

  def show
    load_neighborhood_or_redirect; return if performed?
    redirect_to about_neighborhood_path(@neighborhood)
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
    load_claims
  end

  private

  def load_neighborhood_or_redirect
    redirect_to root_path unless @neighborhood = Neighborhood.friendly.find(params[:id])
  end

  def load_meetings
    @meetings = @neighborhood.meetings.order(date: :desc).group_by { |x| x.date.year }
  end

  def load_assets_and_claims
    @assets_and_claims = load_assets + load_claims
  end

  def load_assets
    @assets = @neighborhood.assets
  end

  def load_claims
    @claims = @neighborhood.claims
  end

end
