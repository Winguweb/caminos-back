class NeighborhoodsController < ApplicationController
  before_action :check_for_mobile, only: %i[index show about]

  def index
    @neighborhoods = Neighborhood.order('LOWER(name)')
    @urbanized = @neighborhoods.where(urbanization: true).order('LOWER(name)')
    @unurbanized= @neighborhoods.where(urbanization: false).order('LOWER(name)')
  end

  def show
    load_neighborhood_or_redirect; return if performed?
  end

  def about
    require 'csv'

    load_neighborhood_or_redirect
    load_meetings

    incidents = File.read(Rails.root.join('public', 'data', 'incidents.csv'))
    @features = []
    CSV.parse(incidents, headers: true, header_converters: :symbol) do |row|
      @features << find_or_create_claim(row) if point_inside_neighborhood(row)
    end

  end

  def agreement
    load_neighborhood_or_redirect
    if !@neighborhood.agreement.blank? && !@neighborhood.agreement.data.nil?
      @data = JSON.parse(@neighborhood.agreement.data)
    else
      @data = {}
    end
  end

  private

  def point_inside_neighborhood(params)
    geographic_factory = RGeo::Geographic.spherical_factory
    claim_point = geographic_factory.point(params[:longitude], params[:latitude])
    @neighborhood.geometry.intersects? claim_point
  end

  def load_neighborhood_or_redirect
    redirect_to root_path unless @neighborhood = Neighborhood.friendly.find(params[:id])
  end

  def load_meetings
    @meetings = @neighborhood.meetings.order(date: :desc).group_by { |x| x.date.year }
  end

  def find_or_create_claim(params)

    a = Claim.find_or_create_by(name: params[:incident_title], description: params[:incident_description]) do |claim|
      claim.geometry = "POINT(#{params[:latitude]} #{params[:longitude]})"
      claim.geo_geometry = "POINT(#{params[:latitude]} #{params[:longitude]})"
      claim.status = 'opened'
      claim.neighborhood = @neighborhood
      claim.category_list = params[:categoria]
    end
  end

end
