class Elements::MapEditCell < Cell::ViewModel

  private

  def polygon
    return [] if model[:polygon].blank?
    model[:polygon].coordinates.first.map(&:reverse)
  end

  def marker
    return [] if options[:work].blank?
    {
      coordinates: options[:work].geometry.coordinates,
      icon: image_path(options[:work].category_icon)
    }.to_json
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

  def edit
    options[:edit] || false
  end

  def controls
    {
      polygon: options[:controls].include?('polygon'),
      marker: options[:controls].include?('marker'),
      polyline: options[:controls].include?('polyline'),
      circlemarker: options[:controls].include?('circlemarker'),
      rectangle: options[:controls].include?('rectangle'),
      circle: options[:controls].include?('circle')
    }
  end

end
