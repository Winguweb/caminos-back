class Elements::NeighborhoodsListCell < Cell::ViewModel
  include LayoutHelper

  private

  def neighborhoods
    @neighborhoods ||= model[:neighborhoods]
  end

end
