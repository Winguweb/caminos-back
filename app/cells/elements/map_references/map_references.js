CDLV.Components['map_references'] = Backbone.View.extend({
  initialize: function(options) {
    _.bindAll(
      this,
      'centerMap',
      'createMap',
      'loadDefaults',
      'setAccessToken',
      'setMapContainer',
      'showBaseGeometry',
    )

    this.setAccessToken(options.token)

    this.setMapContainer('#map-container')

    this.loadDefaults(options)

    this.createMap()

    this.configureMapForMobile()

    this.showBaseGeometry()

    this.centerMap(this.base)
  },
  centerMap: function(polygons) {
    this.map.fitBounds(this.baseGeometryFeature.getBounds())
  },
  configureMapForMobile: function() {
    if ($('html').hasClass('touchevents')) {this.map.dragging.disable()}
  },
  createMap: function() {
    this.map = L.mapbox.map(this.mapContainer[0], this.style)
    this.baseGeometryFeature = new L.FeatureGroup()
    this.map.addLayer(this.baseGeometryFeature)
  },
  loadDefaults: function(options) {
    this.center = options.defaults.center
    this.base = options.base
    this.style = options.defaults.style
    this.zoom = options.defaults.zoom
  },
  setAccessToken: function(token) {
    L.mapbox.accessToken = token
  },
  setMapContainer: function(selector) {
    this.mapContainer = this.$el.find(selector)
  },
  showBaseGeometry: function() {
    L.geoJSON(this.base).addTo(this.baseGeometryFeature)
  },
})
