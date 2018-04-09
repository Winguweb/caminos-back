CDLV.Components['map_show'] = Backbone.View.extend({
  initialize: function(options) {
    _.bindAll(
      this,
      'centerMap',
      'createMap',
      'getCenter',
      'getBounds',
      'loadDefaults',
      'setAccessToken',
      'setMapContainer',
      'showBaseGeometry',
      'showFeaturesGeometry',
      'showMarkers',
      'showPolygon'
    )

    this.setAccessToken(options.token)

    this.setMapContainer('#map-container')

    this.loadDefaults(options)

    this.createMap()

    this.showBaseGeometry()

    this.showFeaturesGeometry()

    this.centerMap(this.base)

    this.zoomMap(this.base)
  },
  centerMap: function(polygon) {
    var center = this.getCenter(polygon) || this.center
    this.map.setView([center.x, center.y], this.zoom)
  },
  createMap: function() {
    this.map = L.mapbox.map(this.mapContainer[0], this.style)
    this.baseGeometryFeature = new L.FeatureGroup()
    this.map.addLayer(this.baseGeometryFeature)
  },
  getBounds: function(polygon) {
    var points = polygon.coordinates.map(function(point) {
      return new L.Point(point[0], point[1])
    })
    return new L.Bounds(points)
  },
  getCenter: function(polygon) {
    var bounds = this.getBounds(polygon)
    return bounds.getCenter()
  },
  hasBaseGeometry: function() {
    return !_.isEmpty(this.base)
  },
  loadDefaults: function(options) {
    this.center = options.defaults.center
    this.geometryStyles = options.defaults.geometry_styles
    this.markerShadowURL = options.defaults.marker_shadow_url
    this.base = options.base
    this.features = options.features
    this.style = options.defaults.style
    this.zoom = options.defaults.zoom
  },
  setAccessToken: function(token) {
    L.mapbox.accessToken = token
  },
  showBaseGeometry: function() {
    if (!this.hasBaseGeometry()) return
    this.showPolygon(this.base)
  },
  setMapContainer: function(selector) {
    this.mapContainer = this.$el.find(selector)
  },
  showFeaturesGeometry: function() {
    this.features.forEach(function(feature) {
      this.showGeometry(feature)
    }.bind(this))
  },
  showGeometry: function(geometry) {
    switch (geometry.type) {
      case 'marker':
        this.showMarkers(geometry)
        break
      case 'polygon':
        this.showPolygon(geometry)
        break
    }
  },
  showMarkers: function(marker) {
    new L.Marker(marker.coordinates[0], {
      icon: L.icon({
        className: "marker",
        iconAnchor: [20, 30],
        iconSize: [40, 40],
        iconUrl: marker.icon,
        shadowAnchor: [19, 29],
        shadowSize: [40, 40],
        shadowUrl: this.markerShadowURL,
      }
    )}).addTo(this.baseGeometryFeature)
  },
  showPolygon: function(polygon) {
    new L.Polygon(polygon.coordinates, {
      className: polygon.className,
    }).addTo(this.baseGeometryFeature)
    this.zoom = 14
  },
  zoomMap: function(polygon) {
    var bounds = this.getBounds(polygon)
    this.map.fitBounds([[bounds.min.x, bounds.min.y], [bounds.max.x, bounds.max.y]], {animate: false})
  },
})
