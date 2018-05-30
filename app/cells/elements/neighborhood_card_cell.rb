class Elements::NeighborhoodCardCell < Cell::ViewModel
  include LayoutHelper

  private

  def neighborhood
    @neighborhood ||= model
  end

  def average
    if neighborhood
      # binding.pry
      indicators = JSON.parse(neighborhood.agreement.data)
      average = indicators.sum do |indicator|
        indicator[1]["score"].to_i
      end
      average / indicators.length
    end
  end

end
