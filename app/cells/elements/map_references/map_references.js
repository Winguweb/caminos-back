CDLV.Components['map_references'] = Backbone.View.extend({
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
      'showReference'
    )

    this.setAccessToken(options.token)

    this.setMapContainer('#map-container')

    this.loadDefaults(options)

    this.createMap()

    this.showBaseGeometry()

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
  createPoints: function(points) {
    return points.coordinates.map(function(point) {
      return new L.Point(point[0], point[1])
    })
  },
  getBounds: function(polygons) {
    if (polygons instanceof Array) {
      var points = []
      for (var i in polygons) {
        var polygon = polygons[i]
        points = points.concat(this.createPoints(polygon))
      }
    } else {
      var points = this.createPoints(polygons)
    }

    return new L.Bounds(points)
  },
  getCenter: function(polygon) {
    var bounds = this.getBounds(polygon)
    return bounds.getCenter()
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
    this.base.forEach(function(polygon) {
      this.showReference (polygon)
    }.bind(this))
  },
  showReference: function(polygon) {
    var center = this.getCenter(polygon)
    var coordinates = new L.latLng(center.x, center.y)
    new L.Marker(coordinates, {
      icon: new L.divIcon({
        html: '<p class="reference-marker"><span>' + polygon.reference + '</span></p>'
      })
    }).addTo(this.baseGeometryFeature)
  },
  zoomMap: function(polygon) {
    var bounds = this.getBounds(polygon)
    this.map.fitBounds([[bounds.min.x, bounds.min.y], [bounds.max.x, bounds.max.y]], {animate: false})
  },
})
