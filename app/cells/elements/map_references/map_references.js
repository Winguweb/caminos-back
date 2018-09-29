CDLV.Components['map_references'] = Backbone.View.extend({
  initialize: function(options) {
    this.loadDefaults(options)
    this.setAccessToken()
    this.createMap()
    this.configureMapForMobile()
    this.showBaseGeometry()
    this.centerMap(this.base)
  },
  centerMap: function() {
    this.map.fitBounds(this.baseGeometryFeature.getBounds())
  },
  configureMapForMobile: function() {
    if ($('html').hasClass('touchevents')) {this.map.dragging.disable()}
  },
  createMap: function() {
    var mapContainer = this.$el.find('#map-container')[0]
    this.map = L.mapbox.map(mapContainer, this.style)
    this.baseGeometryFeature = new L.FeatureGroup()
    this.map.addLayer(this.baseGeometryFeature)
  },
  loadDefaults: function(options) {
    this.base = options.base
    this.center = options.defaults.center
    this.style = options.defaults.style
    this.token = options.token
    this.zoom = options.defaults.zoom
  },
  setAccessToken: function() {
    L.mapbox.accessToken = this.token
  },
  showBaseGeometry: function() {
    L.geoJSON(this.base).addTo(this.baseGeometryFeature)
  },
})
