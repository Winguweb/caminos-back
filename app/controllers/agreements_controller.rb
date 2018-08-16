class AgreementsController < ApplicationController
  before_action :check_for_mobile, :only => [:agreement]

  def show
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
end
