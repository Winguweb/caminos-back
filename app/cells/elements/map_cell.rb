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

  def markers
    options[:works] ? options[:works].map do |work|
      work.geometry.coordinates
    end : []
  end

  def set_marker
    options[:set_marker] ? true : false
  end

  def geo_markers
    options[:works] ? options[:works].map do |work|
      work.geo_geometry.coordinates
    end : []
  end

end
