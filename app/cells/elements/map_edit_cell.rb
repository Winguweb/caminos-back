class Elements::MapEditCell < Cell::ViewModel

  private

  def base
    return [] if model[:geometry].blank?
    case model[:geometry].geometry_type
      when RGeo::Feature::Polygon
      {
        coordinates: model[:geometry].coordinates.first.map(&:reverse),
        className: 'base-geometry',
      }.to_json
      when RGeo::Feature::MultiPolygon
      {
        coordinates: model[:geometry].coordinates.map {|polygons| polygons.first.map(&:reverse)},
        className: 'base-geometry',
      }.to_json
    end
  end

  def editable
    return [] if options[:editable].blank?
    case options[:editable][:geometry].geometry_type
    when RGeo::Feature::Point
      {
        coordinates: [options[:editable].geometry.coordinates].map(&:reverse),
        className: 'editable',
        type: 'Point',
      }.to_json
    when RGeo::Feature::MultiPoint
      {
        coordinates: options[:editable].geometry.coordinates.map(&:reverse),
        className: 'editable',
        type: 'Point',
      }.to_json
    when RGeo::Feature::Polygon
      {
        coordinates: options[:editable].geometry.coordinates.first.map(&:reverse),
        className: 'editable',
        type: 'Polygon',
      }.to_json
    when RGeo::Feature::MultiPolygon
      {
        coordinates: options[:editable].geometry.coordinates.map {|polygons| polygons.first.map(&:reverse)},
        className: 'editable',
        type: 'MultiPolygon',
      }.to_json
    when RGeo::Feature::LineString
      {
        coordinates: options[:editable].geometry.coordinates.map(&:reverse),
        className: 'editable',
        type: 'Polyline',
      }.to_json
    when RGeo::Feature::MultiLineString
      {
        coordinates: options[:editable].geometry.coordinates.map { |lines| lines.map(&:reverse) },
        className: 'editable',
        type: 'Polyline',
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
