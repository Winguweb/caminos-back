class Elements::MapReferencesCell < Cell::ViewModel

  private

  def base
    return [] if model.blank?
    factory = RGeo::GeoJSON::EntityFactory.instance

    features = model.map do |neighborhood|
      factory.feature(neighborhood.geo_geometry, nil, {
        className: neighborhood.urbanization ? 'urbanized' : 'unurbanized',
        abbreviation: neighborhood.abbreviation,
        name: neighborhood.name,
        url: neighborhood_path(neighborhood.slug),
        urbanization_process: neighborhood.urbanization ? 'urbanized' : 'unurbanized',
        asset_url: new_neighborhood_asset_path(neighborhood.slug),
        claim_url: new_neighborhood_claim_path(neighborhood.slug),
      })
    end

    geoJson = RGeo::GeoJSON.encode factory.feature_collection(features)

    geoJson.to_json
  end

  def map_defaults
    MAP.merge(
      "marker_shadow_url" => image_url(MAP["marker_shadow_url"]),
      "marker_editable_url" => image_url(MAP["marker_editable_url"]),
    ).to_json
  end
end
