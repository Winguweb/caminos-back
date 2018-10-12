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

    this.configureMapForMobile()

    this.showBaseGeometry()

    this.centerMap(this.base)

    this.zoomMap(this.base)
  },
  centerMap: function(polygons) {
    var polygonsCenters = polygons.map(function(polygon) {
      var center = this.getCenter(polygon)
      return center
    }.bind(this))

    var center = this.getCenter({coordinates: polygonsCenters}) || this.center
    this.map.setView([center.x, center.y], this.zoom)
  },
  configureMapForMobile: function() {
    if ($('html').hasClass('touchevents')) {this.map.dragging.disable()}
  },
  createMap: function() {
    this.map = L.mapbox.map(this.mapContainer[0], this.style)
    L.mapbox.styleLayer('mapbox://styles/juanlacueva/cjn4oy3d40mfz2rnn6z5bngy1').addTo(this.map);
    this.baseGeometryFeature = new L.FeatureGroup()
    this.map.addLayer(this.baseGeometryFeature)
  },
  createPoints: function(points) {
    return points.coordinates.map(function(point) {
      return new L.Point(point[0], point[1])
    })
  },
  getBounds: function(polygon) {
    return new L.Bounds(polygon.coordinates)
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
    polygon.coordinates = polygon.coordinates.length == 1 ? polygon.coordinates[0] : polygon.coordinates
    var center = this.getCenter(polygon)
    var coordinates = new L.latLng(center.x, center.y)

    new L.Marker(coordinates, {
      icon: new L.divIcon({
        html: '<div><p class="marker-name ' + polygon.className + '">' + polygon.name + '</p><p class="reference-marker ' + polygon.className + '"><span>' + polygon.reference + '</span></p></div>'
      })
    }).addTo(this.baseGeometryFeature)
  },
  zoomMap: function(polygons) {
    var polygonsCenters = polygons.map(function(polygon) {
      var center = this.getCenter(polygon)
      return center
    }.bind(this))
    var bounds = this.getBounds({coordinates: polygonsCenters})
    this.map.fitBounds([[bounds.min.x, bounds.min.y], [bounds.max.x, bounds.max.y]], {animate: false, padding: [50,50]})
  },
})
