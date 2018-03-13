class Elements::HomeNeighborhoodListCell < Cell::ViewModel

  private

  def neighborhoods
    @neighborhoods ||= model
  end

end
