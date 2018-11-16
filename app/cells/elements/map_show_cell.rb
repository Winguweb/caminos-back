class Elements::MapShowCell < Cell::ViewModel

  private

  def info_content
    options[:info]
  end

  def base
    return [] if model.blank?
    factory = RGeo::GeoJSON::EntityFactory.instance

    feature = factory.feature(model.geo_geometry, nil, {
      className: 'base-geometry',
      #TO-DO watch this later
      # url: neighborhood_work_path(model)
    })

    geoJson = RGeo::GeoJSON.encode feature

    geoJson.to_json
  end

  def features
    return [] if options[:features].blank?
    factory = RGeo::GeoJSON::EntityFactory.instance
    _size_normal = {width: 40, height: 40}
    _size_small = {width: 25, height: 25}
    features = options[:features].map do |feature|
      factory.feature(feature.geo_geometry, nil, {
        icon: image_path(feature.category_icon),
        iconShadow: image_path(feature.category_icon_shadow),
        type: 'marker',
        url: neighborhood_work_path(feature.neighborhood, feature),
        show: true,
        category: feature.category.name,
        status: feature[:status],
        name: feature[:name],
        size: feature.class.name == 'Work' ? _size_normal : _size_small,
        class: feature.class.name
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
