module Admin
  module AgreementsHelper
    include NeighborhoodsHelper

  def average(neighborhood = current_neighborhood)
      if neighborhood
        return 0 if neighborhood.agreement.data.nil?
        indicators = JSON.parse(neighborhood.agreement.data)
        total_average = indicators.sum do |indicator|
          indicator[1]["score"].to_i
        end
        total_average / indicators.length
      end
    end
  end
end
