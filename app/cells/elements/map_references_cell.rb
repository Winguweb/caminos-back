class Elements::MapReferencesCell < Cell::ViewModel

  private

  def base
    if model.kind_of?(ActiveRecord::Relation)
      reference_number = 0
      model.map do |neighborhood|
        reference_number += 1
        {
            coordinates: neighborhood[:geometry].coordinates.first.map(&:reverse),
            className: 'base-geometry',
            reference: reference_number
        }

      end.to_json
    elsif model.kind_of?(Neighborhood)
      {
          coordinates: model[:geometry].coordinates.first.map(&:reverse),
          className: 'base-geometry',
      }.to_json
    else
      return []
    end
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
      when RGeo::Feature::Polygon
        {
          coordinates: feature[:geometry].coordinates.first.map(&:reverse),
          className: feature.category,
          type: 'polygon',
        }
      when RGeo::Feature::LineString
        {
          coordinates: feature[:geometry].coordinates.map(&:reverse),
          className: feature.category,
          type: 'polyline',
        }
      end
    end.to_json
  end

  def as_references
    return options[:as_references]
  end

  def map_defaults
    MAP.merge(
      "marker_shadow_url" => image_url(MAP["marker_shadow_url"]),
      "marker_editable_url" => image_url(MAP["marker_editable_url"]),
    ).to_json
  end
end
