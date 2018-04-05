class Elements::MapEditCell < Cell::ViewModel

  private

  def polygon

    if !model[:polygon].nil? && model[:polygon].present?
      polygon = model[:polygon]
      polygon.coordinates.first.map do |coords|
        coords.reverse
      end
    else
      []
    end
  end

  def geo_polygon
    geo_polygon = model[:geo_polygon]
    return [] if geo_polygon.nil?
    geo_polygon.coordinates.first.map do |coords|
      coords.reverse
    end
  end

  def markers
    options[:works] ? options[:works].map do |work|
      work.geometry.coordinates
    end : []
  end

  def set_marker
    options[:set_marker] ? true : false
  end

  def set_polygon
    options[:set_polygon] ? true : false
  end

  def object_to_set
    return 'work' if options[:set_marker]
    return 'neighborhood' if options[:set_polygon]
  end

  def map_geo_property
    return 'geo_geometry' if options[:set_marker]
    return 'geo_polygon' if options[:set_polygon]
  end

  def map_property
    return 'geometry' if options[:set_marker]
    return 'polygon' if options[:set_polygon]
  end

  def geo_markers
    options[:works] ? options[:works].map do |work|
      work.geo_geometry.coordinates
    end : []
  end

end
