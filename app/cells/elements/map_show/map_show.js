CDLV.Components['map_show'] = Backbone.View.extend({
  initialize: function(options) {

    _.bindAll(
      this,
      'setMapContainer',
      'hasPolygon',
      'hasMarkers',
      'setAccessToken',
      'loadDefaults',
      'createMap',
      'showPolygons',
      'showMarkers',
      'centerMap',
      'getCenter',
    )

    this.setAccessToken(options.token)

    this.setMapContainer('#map-container')

    this.loadDefaults(options)

    this.createMap()

    this.showPolygons()

    this.showMarkers()

    this.centerMap()
  },
  setAccessToken: function(token) {
    L.mapbox.accessToken = token
  },
  setMapContainer: function(selector) {
    this.mapContainer = this.$el.find(selector)
  },
  hasPolygon: function () {
    return !_.isEmpty(this.polygon)
  },
  hasMarkers: function () {
    return !_.isEmpty(this.markers)
  },
  loadDefaults: function(options) {
    this.center = options.defaults.center
    this.zoom = options.defaults.zoom
    this.style = options.defaults.style
    this.markerShadowURL = options.defaults.marker_shadow_url
    this.markers = options.markers
    this.polygon = options.polygon
  },
  createMap: function() {
    this.map = L.mapbox.map(this.mapContainer[0], this.style)
  },
  showPolygons: function() {
    if (!this.hasPolygon()) return
    new L.Polygon(this.polygon).addTo(this.map)
    this.zoom = 14
  },
  showMarkers: function() {
    if (!this.hasMarkers()) return
      var map = this.map
    this.markers.forEach(function(marker) {
      new L.Marker(marker.coordinates, {icon: L.icon({
              iconUrl: marker.icon,
              iconSize: [40, 40],
              iconAnchor: [20, 30],
              className: "marker",
              shadowUrl: this.markerShadowURL,
              shadowSize: [40, 40],
              shadowAnchor: [19, 29],
          }
        )}).addTo(map)
    }.bind(this))
  },
  centerMap: function() {
    var center = this.getCenter() || this.center
    this.map.setView([center.x, center.y], this.zoom);
  },
  getCenter: function() {
    if (!this.hasPolygon()) return
    var points = this.polygon.map(function(point) {
      return new L.Point(point[0], point[1])
    })
    var bounds = new L.Bounds(points)
    return bounds.getCenter()
  }
})
