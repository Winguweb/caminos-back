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
      'showPolygon',
      'addClickEvent',
      'changeCategoryFilter',
      'changeStatusFilter'
    )

    this.setAccessToken(options.token)

    this.setMapContainer('#map-container')

    this.loadDefaults(options)

    this.createMap()

    this.configureMapForMobile()

    this.showBaseGeometry()

    this.showFeaturesGeometry()

    this.centerMap(this.base)

    this.zoomMap(this.base)

    CDLV.pubSub.on({
      'map-show:filter:category': this.changeCategoryFilter,
      'map-show:filter:status': this.changeStatusFilter
    })
  },
  addClickEvent: function(element) {
    element.on('click', function (evt) {
      window.location = evt.target.options.url
    })
  },
  centerMap: function(polygon) {
    var center = this.getCenter(polygon) || this.center
    this.map.setView([center.x, center.y], this.zoom)
  },
  changeCategoryFilter: function(categoryName) {
    this.categoryFilter = categoryName
    this.filterFeatures()
    this.baseGeometryFeature.clearLayers()
    this.showBaseGeometry()
    this.showFeaturesGeometry()
  },
  changeStatusFilter: function(statusName) {
    this.statusFilter = statusName
    this.categoryFilter = null
    this.filterFeatures()
    this.baseGeometryFeature.clearLayers()
    this.showBaseGeometry()
    this.showFeaturesGeometry()
  },
  configureMapForMobile: function() {
    if ($('html').hasClass('touchevents')) {this.map.dragging.disable()}
  },
  createMap: function() {
    this.map = L.mapbox.map(this.mapContainer[0], this.style, {scrollWheelZoom: false})
    this.baseGeometryFeature = new L.FeatureGroup()
    this.map.addLayer(this.baseGeometryFeature)
  },
  filterFeatures: function() {
    this.features.forEach(function(feature) {
      passCategoryFilter = (feature.category == this.categoryFilter) || !this.categoryFilter
      passStatusFilter = (feature.status == this.statusFilter) || !this.statusFilter
      feature.show = passCategoryFilter && passStatusFilter
    }.bind(this))
  },
  getBounds: function(polygon) {
    var coordinates = polygon.coordinates[0][0] instanceof Array ? polygon.coordinates[0] : polygon.coordinates
    return new L.Bounds(coordinates)
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

    this.categoryFilter = null
    this.statusFilter = null
  },
  setAccessToken: function(token) {
    L.mapbox.accessToken = token
  },
  setMapContainer: function(selector) {
    this.mapContainer = this.$el.find(selector)
  },
  showBaseGeometry: function() {
    if (!this.hasBaseGeometry()) return
    this.showPolygon(this.base, {fixed: true})
  },
  showFeaturesGeometry: function() {
    this.features.forEach(function(feature) {
      if (feature.show) this.showGeometry(feature)
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
      case 'polyline':
        this.showPolyline(geometry)
        break
    }
  },
  showMarkers: function(marker) {
    var points =  marker.coordinates[0] instanceof Array ? marker.coordinates : [marker.coordinates]
    points.forEach(function(point) {
      var newMarker = new L.Marker(point, {
        icon: L.icon({
          className: "geometry-marker",
          iconAnchor: [20, 30],
          iconSize: [40, 40],
          iconUrl: marker.icon,
          shadowAnchor: [19, 29],
          shadowSize: [40, 40],
          shadowUrl: this.markerShadowURL,
        }),
        url: marker.url
      }).addTo(this.baseGeometryFeature)
      this.addClickEvent(newMarker)
    }.bind(this))
  },
  showPolygon: function(polygon, options) {
    var newPolygon = new L.Polygon(polygon.coordinates, {
      className: "geometry-polygon " + polygon.className,
      url: polygon.url
    }).addTo(this.baseGeometryFeature)
    if (!options || !options.fixed) this.addClickEvent(newPolygon)
  },
  showPolyline: function(polyline, options) {
    var parent = options && options.fixed ? this.baseGeometryFeature : this.editableGeometryFeature
    var newPolyline = new L.Polyline(polyline.coordinates,
      {
        className: "geometry-polyline " + polyline.className,
        url: polyline.url
      }).addTo(this.baseGeometryFeature)
    this.addClickEvent(newPolyline)
  },
  zoomMap: function(polygon) {
    var bounds = this.getBounds(polygon)
    this.map.fitBounds([[bounds.min.x, bounds.min.y], [bounds.max.x, bounds.max.y]], {animate: false})
  },
})
