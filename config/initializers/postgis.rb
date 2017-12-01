RGeo::ActiveRecord::SpatialFactoryStore.instance.tap do |config|
  config.register(RGeo::Geographic.spherical_factory(srid: 4326), geo_type: "point")
end

RGeo::ActiveRecord::GeometryMixin.set_json_generator(:geojson)
