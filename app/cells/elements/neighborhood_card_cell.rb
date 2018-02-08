class Elements::NeighborhoodCardCell < Cell::ViewModel

  private

  def neighborhood
    @neighborhood ||= model
  end

end
