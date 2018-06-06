class Elements::MapReferencesCell < Cell::ViewModel

  private

  def base
    return [] if model.blank?
    model.map do |neighborhood|
      case neighborhood.geometry.try(:geometry_type)
      when RGeo::Feature::Polygon
        {
          coordinates: neighborhood.geometry.coordinates.first.map(&:reverse),
          className: neighborhood.urbanization ? 'urbanized' : 'unurbanized',
          name: neighborhood.name,
          reference: neighborhood.abbreviation
        }
      when RGeo::Feature::MultiPolygon
        {
          coordinates: neighborhood.geometry.coordinates.first.first.map(&:reverse),
          className: neighborhood.urbanization ? 'urbanized' : 'unurbanized',
          name: neighborhood.name,
          reference: neighborhood.abbreviation
        }
      else
        {
          coordinates: [],
          className: neighborhood.urbanization ? 'urbanized' : 'unurbanized',
          name: neighborhood.name,
          reference: neighborhood.abbreviation
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
