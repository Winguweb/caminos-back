class Elements::NeighborhoodsListCell < Cell::ViewModel

  private

  def neighborhoods
    @neighborhoods ||= model[:neighborhoods]
  end

end
