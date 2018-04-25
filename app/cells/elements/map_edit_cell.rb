class Elements::MapEditCell < Cell::ViewModel

  private

  def base
    return [] if model[:geometry].blank?
    {
      coordinates: model[:geometry].coordinates.first.map(&:reverse),
      className: 'base-geometry',
    }.to_json
  end

  def editable
    return [] if options[:editable].blank?
    case options[:editable][:geometry].geometry_type
    when RGeo::Feature::Point
      {
        coordinates: [options[:editable].geometry.coordinates],
        icon: image_path(options[:editable].category_icon),
        type: 'marker',
      }.to_json
    when RGeo::Feature::Polygon
    when RGeo::Feature::MultiLineString
      {
        coordinates: options[:editable].geometry.coordinates.first.map(&:reverse),
        className: 'editable',
        type: 'polygon',
      }.to_json
    when RGeo::Feature::LineString
      {
        coordinates: options[:editable].geometry.coordinates.map(&:reverse),
        className: options[:editable].category,
        type: 'polyline',
      }.to_json
    end
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

  def map_defaults
    MAP.merge(
      "marker_shadow_url" => image_url(MAP["marker_shadow_url"]),
      "marker_editable_url" => image_url(MAP["marker_editable_url"]),
    ).to_json
  end

end
