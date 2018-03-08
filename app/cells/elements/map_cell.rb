class Elements::MapCell < Cell::ViewModel

  private

  def polygon
    polygon = model[:polygon]

    polygon.coordinates.first.map do |coords|
      coords.reverse
    end
  end

  def geo_polygon
    model[:geo_polygon]
  end

end
