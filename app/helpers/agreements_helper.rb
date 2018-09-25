module AgreementsHelper
  def average(neighborhood = @neighborhood)
    if neighborhood
      indicators = JSON.parse(neighborhood.agreement.data)
      return 0 if indicators.blank?

      average = indicators.sum do |indicator|
        indicator[1]["score"].to_i
      end
      average / indicators.length
    end
  end
end
