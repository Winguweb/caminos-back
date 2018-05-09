class Elements::MapShowCell < Cell::ViewModel

  private

  def info_content
    options[:info]
  end

  def base
    return [] if model[:geometry].blank?
    {
      coordinates: model[:geometry].coordinates.first.map(&:reverse),
      className: 'base-geometry',
    }.to_json
  end

  def features
    return [] if options[:features].blank?
    options[:features].map do |feature|
      case feature[:geometry].geometry_type
      when RGeo::Feature::Point
        {
          coordinates: [feature[:geometry].coordinates],
          icon: image_path(feature.category_icon),
          type: 'marker',
        }
      when RGeo::Feature::MultiPoint
      {
        coordinates: feature[:geometry].coordinates.map(&:reverse),
        icon: image_path(feature.category_icon),
        type: 'marker',
      }
      when RGeo::Feature::Polygon
        {
          coordinates: feature[:geometry].coordinates.first.map(&:reverse),
          className: feature.category.name,
          type: 'polygon',
        }
      when RGeo::Feature::MultiPolygon
        {
          coordinates: feature[:geometry].coordinates.map {|polygons| polygons.first.map(&:reverse)},
          className: feature.category.name,
          type: 'polygon',
        }
      when RGeo::Feature::LineString
        {
          coordinates: feature[:geometry].coordinates.map(&:reverse),
          className: feature.category.name,
          type: 'polyline',
        }
      when RGeo::Feature::MultiLineString
        {
          coordinates: feature[:geometry].coordinates.map { |lines| lines.map(&:reverse) },
          className: feature.category.name,
          type: 'polyline',
        }
      end
    end.to_json
  end

  def map_defaults
    MAP.merge(
      "marker_shadow_url" => image_url(MAP["marker_shadow_url"]),
      "marker_editable_url" => image_url(MAP["marker_editable_url"]),
    ).to_json
  end
end
