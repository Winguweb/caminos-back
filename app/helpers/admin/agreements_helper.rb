module Admin
  module AgreementsHelper
    include NeighborhoodsHelper

  def average(neighborhood = current_neighborhood)
      if neighborhood
        return 0 if neighborhood.agreement.data.nil?
        indicators = JSON.parse(neighborhood.agreement.data)
        total_average = indicators.sum do |indicator|

          # total = Agreement.indicators[indicator[0]][:total]

          indicator[1]["score"].to_i
        end
        total_average
      end
    end
  end
end
