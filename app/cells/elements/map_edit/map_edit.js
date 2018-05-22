CDLV.Components['map_edit'] = Backbone.View.extend({
  initialize: function(options) {
    _.bindAll(
      this,
      'addControls',
      'bindDrawEvents',
      'centerMap',
      'clearInputs',
      'createMap',
      'getBounds',
      'getCenter',
      'getFocusedGeometry',
      'hasEditableGeometry',
      'loadDefaults',
      'persistGeometry',
      'saveInputs',
      'setAccessToken',
      'setInputs',
      'setMapContainer',
      'setUpStyles',
      'showEditableGeometry',
      'showBaseGeometry',
      'showPoint',
      'showPolygon',
      'updateControls',
      'zoomMap'
    )

    this.setAccessToken(options.token)

    this.setMapContainer('#map-container')

    this.loadDefaults(options)

    this.setUpStyles()

    this.createMap()

    this.setInputs()

    this.addControls()

    this.bindDrawEvents()

    this.showBaseGeometry()

    this.showEditableGeometry()

    this.centerMap(this.getFocusedGeometry())

    this.zoomMap(this.getFocusedGeometry())

    this.orderGeometry()
  },
  addControls: function() {
    this.map.addControl(this.generateControls());
  },
  generateControls: function() {
    var drawingControls = {
      position: 'topright',
      draw: {
        circle: false,
        circlemarker: false,
        marker: this.featureType ? this.featureType == 'Point' && this.geometryStyles.marker : this.geometryStyles.marker,
        polygon: this.featureType ? this.featureType == 'Polygon' && this.geometryStyles.polygon : this.geometryStyles.polygon,
        polyline: this.featureType ? this.featureType == 'Polyline' && this.geometryStyles.polyline : this.geometryStyles.polyline,
        rectangle: false,
      },
      edit: this.featureType && {
        featureGroup: this.editableGeometryFeature,
      },
    }

    this.drawingControls = new L.Control.Draw(drawingControls)

    window.drawingControls = this.drawingControls

    return this.drawingControls
  },
  bindDrawEvents: function() {
    this.map.on('draw:created', function (e) {
      this.featureType = this.layerTypeToFeatureType(e.layerType)
      this.persistGeometry(e.layer)
      this.updateGeometryInput(this.editableGeometryFeature.getLayers())
      this.updateControls()
    }.bind(this))
    this.map.on('draw:editstop', function (e) {
      var layers = this.editableGeometryFeature.getLayers()
      this.updateGeometryInput(layers)
    }.bind(this))
    this.map.on("draw:deletestop", function(e) {
      var layers = this.editableGeometryFeature.getLayers()
      this.updateGeometryInput(layers)

      if (lastGeometry(this.editableGeometryFeature)) {
        this.featureType = null
        this.updateControls()
      }
      function lastGeometry(geom) {return geom.getLayers().length == 0}
    }.bind(this));
  },
  centerMap: function(polygon) {
    polygon.coordinates = polygon.coordinates.length == 1 ? polygon.coordinates[0] : polygon.coordinates
    var center = _.isEmpty(polygon) ? this.center : this.getCenter(polygon)
    this.map.setView([center.x, center.y], this.zoom)
  },
  createMap: function() {
    this.map = L.mapbox.map(this.mapContainer[0], this.style)
    this.editableGeometryFeature = new L.FeatureGroup()
    this.baseGeometryFeature = new L.FeatureGroup()
    this.map.addLayer(this.editableGeometryFeature)
    this.map.addLayer(this.baseGeometryFeature)
  },
  clearInputs: function() {
    this.inputGeometry.val(null)
    this.inputGeo_geometry.val(null)
  },
  hasBaseGeometry: function () {
    return !_.isEmpty(this.base)
  },
  hasEditableGeometry: function () {
    return !_.isEmpty(this.editable)
  },
  layerTypeToFeatureType: function(type) {
    return {
      marker: 'Point',
      polygon: 'Polygon',
      polyline: 'Polyline',
    }[type]
  },
  loadDefaults: function(options) {
    this.center = options.defaults.center
    this.controls = options.controls
    this.geometryStyles = options.defaults.geometry_styles
    this.editable = options.editable
    this.markerEditableURL = options.defaults.marker_editable_url
    this.markerShadowURL = options.defaults.marker_shadow_url
    this.fieldName = options.name
    this.base = options.base
    this.style = options.defaults.style
    this.zoom = options.defaults.zoom
  },
  getBounds: function(polygon) {
    return new L.Bounds(polygon.coordinates)
  },
  getCenter: function(polygon) {
    return this.getBounds(polygon).getCenter()
  },
  getFocusedGeometry: function() {
    return this.hasBaseGeometry() ? this.base : this.editable
  },
  orderGeometry: function() {
    this.baseGeometryFeature.bringToBack()
  },
  persistGeometry: function(layer) {
    layer.addTo(this.editableGeometryFeature);
  },
  saveInputs: function(value) {
    this.inputGeometry.val(value)
    this.inputGeo_geometry.val(value)
  },
  setAccessToken: function(token) {
    L.mapbox.accessToken = token
  },
  setInputs: function() {
    this.inputGeometry = $('.geometry-field')
    this.inputGeo_geometry = $('.geo_geometry-field')
    var GEOMETRY_TYPE = {
      "MultiPolygon": "Polygon",
      "Polygon": "Polygon",
      "Polyline": "Polyline",
      "Point": "Polyline", /* Its converted to MultiPoint later */
    }
    if(this.hasEditableGeometry()) {
      var coordinates = this.editable.coordinates
      if (this.editable.type == 'MultiPolygon') {
        coordinates = coordinates.map(function(coordinate) { return [coordinate]})
      }
      var geoJsonGeometry = (new L[GEOMETRY_TYPE[this.editable.type]](coordinates)).toGeoJSON()
      if (this.editable.type == 'Point') geoJsonGeometry.geometry.type = 'MultiPoint'
      var WKTGeometry = wellknown.stringify(geoJsonGeometry)
      this.saveInputs(WKTGeometry)
      this.featureType = this.editable.type
    }
  },
  setMapContainer: function(selector) {
    this.mapContainer = this.$el.find(selector)
  },
  setUpStyles: function() {
    var options = {
      marker: {
        icon: L.icon({
          className: "geometry-marker",
          iconAnchor: [20, 30],
          iconSize: [40, 40],
          iconUrl: this.markerEditableURL,
          shadowAnchor: [19, 29],
          shadowSize: [40, 40],
          shadowUrl: this.markerShadowURL,
        })
      }
    }

    this.geometryStyles = _.extend(this.geometryStyles, options)
  },
  showBaseGeometry: function() {
    if (!this.hasBaseGeometry()) return
    this.showPolygon(this.base, {fixed: true})
  },
  showEditableGeometry: function() {
    if (!this.hasEditableGeometry()) return
    switch (this.editable.type) {
      case 'Point':
        this.showPoint(this.editable)
        break
      case 'Polygon':
      case 'MultiPolygon':
        this.showPolygon(this.editable)
        break
      case 'Polyline':
        this.showPolyline(this.editable)
        break
    }
  },
  showPoint: function(point, options) {
    var parent = options && options.fixed ? this.baseGeometryFeature : this.editableGeometryFeature
    var points =  point.coordinates[0] instanceof Array ? point.coordinates : [point.coordinates]
    points.forEach(function(_point) {
      new L.Marker(_point, this.geometryStyles.marker).addTo(parent)
    }.bind(this))
  },
  showPolygon: function(polygon, options) {
    var parent = options && options.fixed ? this.baseGeometryFeature : this.editableGeometryFeature
    var polygons =  polygon.coordinates[0][0] instanceof Array ? polygon.coordinates : [polygon.coordinates]
    polygons.forEach(function(_polygon) {
      new L.Polygon(_polygon, _.extend(
        this.geometryStyles.polygon,
        {className: "geometry-polygon " + polygon.className}
      )).addTo(parent)
    }.bind(this))
  },
  showPolyline: function(polyline, options) {
    var parent = options && options.fixed ? this.baseGeometryFeature : this.editableGeometryFeature
    var polylines =  polyline.coordinates[0][0] instanceof Array ? polyline.coordinates : [polyline.coordinates]
    polylines.forEach(function(_polyline) {
      new L.Polyline(_polyline, _.extend(
        this.geometryStyles.polyline,
        {className: "geometry-polyline " + polyline.className}
      )).addTo(parent)
    }.bind(this))
  },
  updateControls: function() {
    this.drawingControls && this.map.removeControl(this.drawingControls)
    this.map.addControl(this.generateControls())
  },
  updateGeometryInput: function(layers) {
    if (_.isEmpty(layers)) {this.clearInputs(); return}
    var getLatLngs = function(layer) {
      var fn = layer.getLatLngs || layer.getLatLng
      return fn.call(layer)
    }

    var geometryConstructor = function(params) {
      if (layers[0] instanceof L.Marker) return new L.Polyline(params)
      return new layers[0].constructor(params)
    }

    var geometry = layers.map(function(layer) { return getLatLngs(layer) })
    var geoJsonGeometry = (new geometryConstructor(geometry)).toGeoJSON()
    if (layers[0] instanceof L.Marker) geoJsonGeometry.geometry.type = "MultiPoint"
    var WKTGeometry = wellknown.stringify(geoJsonGeometry)
    this.saveInputs(WKTGeometry)
  },
  zoomMap: function(polygon) {
    if (_.isEmpty(polygon)) return
    var bounds = this.getBounds(polygon)
    this.map.fitBounds([[bounds.min.x, bounds.min.y], [bounds.max.x, bounds.max.y]], {animate: false})
  },
})
