CDLV.Components['map_references'] = Backbone.View.extend({
  initialize: function(options) {
    _.bindAll(
      this,
      'onEachFeature'
    )

    this.loadDefaults(options)
    this.setAccessToken()
    this.createMap()
    this.configureMapForMobile()
    this.showBaseGeometry()
    this.centerMap()
  },
  centerMap: function() {
    this.map.fitBounds(this.baseGeometryFeature.getBounds())
  },
  configureMapForMobile: function() {
    if ($('html').hasClass('touchevents')) {this.map.dragging.disable()}
  },
  createMap: function() {
    var mapContainer = this.$el.find('#map-container')[0]
    this.map = L.mapbox.map(mapContainer, this.style, {scrollWheelZoom: false, maxZoom: 18})
    L.mapbox.styleLayer('mapbox://styles/juanlacueva/cjn4oy3d40mfz2rnn6z5bngy1').addTo(this.map);
    this.baseGeometryFeature = new L.FeatureGroup()
    this.map.addLayer(this.baseGeometryFeature)
  },
  featureClickListener: function(feature) {
    return function() { window.location = feature.properties.url }
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
    var geoJSONFunctions = { onEachFeature: this.onEachFeature }
    var geoJSON = L.geoJSON(this.base, geoJSONFunctions)
    geoJSON.addTo(this.baseGeometryFeature)
  },
  onEachFeature: function(feature, layer){
    var _this = this
    if (['MultiPolygon', 'Polygon'].indexOf(feature.geometry.type) > -1 ) {
      var icon = new L.divIcon({
        html: '<div><p class="marker-name ' + feature.properties.className + '">' + feature.properties.name + '</p><p class="reference-marker ' + feature.properties.className + '"><span>' + feature.properties.abbreviation + '</span></p></div>',
      })
      var centroid = turf.centroid(feature);
      var coordinates = new L.latLng(
        centroid.geometry.coordinates[1],
        centroid.geometry.coordinates[0]
      )

      layer.options.opacity = 0
      layer.options.fill = false

      var marker = L.marker(coordinates, {icon: icon})
      marker.on('click', _this.featureClickListener(feature))
      marker.addTo(this.map)
    }
  }
})
