class Elements::NeighborhoodCardCell < Cell::ViewModel
  include LayoutHelper

  private

  def neighborhood
    @neighborhood ||= model
  end

end
