module Admin
  module AgreementsHelper
    include NeighborhoodsHelper

    def average
      if current_neighborhood
        return 0 if current_neighborhood.agreement.data.nil?
        indicators = JSON.parse(current_neighborhood.agreement.data)
        average = indicators.sum do |indicator|
          indicator[1]["score"].to_i
        end
        average / indicators.length
      end
    end
  end
end
