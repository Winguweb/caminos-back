CDLV.Components['map_edit'] = Backbone.View.extend({
  initialize: function(options) {
    _.bindAll(
      this,
      'addControls',
      'bindDrawEvents',
      'centerMap',
      'createMap',
      'getBounds',
      'getCenter',
      'getFocusedGeometry',
      'hasEditableGeometry',
      'loadDefaults',
      'persistMarker',
      'persistPolygon',
      'setAccessToken',
      'setInputs',
      'setMapContainer',
      'showEditableGeometry',
      'showBaseGeometry',
      'showMarker',
      'showPolygon',
      'updateMarkerInput',
      'updatePolygonInput',
      'zoomMap'
    )

    this.setAccessToken(options.token)

    this.setMapContainer('#map-container')

    this.loadDefaults(options)

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
    this.map.addControl(this.hasEditableGeometry() ? this.generateEditControls() : this.generateCreateControls());
  },
  generateCreateControls: function() {
    var createControls = {
      position: 'topright',
      draw: {
        circle: false,
        circlemarker: false,
        marker: this.featureType ? this.featureType == 'marker' : this.geometryStyles.marker,
        polygon: this.featureType ? this.featureType == 'polygon' : this.geometryStyles.polygon,
        polyline: this.featureType ? this.featureType == 'polyline' : this.geometryStyles.polyline,
        rectangle: false,
      },
    }
    createControls.draw.marker.icon = L.icon(_.extend(createControls.draw.marker.icon, {
      iconUrl: this.markerEditableURL,
      shadowUrl: this.markerShadowURL,
    }))
    return this.createControls = new L.Control.Draw(createControls)
  },
  generateEditControls: function() {
    var editControls = {
      position: 'topright',
      draw: {
        circle: false,
        circlemarker: false,
        marker: this.featureType ? this.featureType == 'marker' : this.geometryStyles.marker,
        polygon: this.featureType ? this.featureType == 'polygon' : this.geometryStyles.polygon,
        polyline: this.featureType ? this.featureType == 'polyline' : this.geometryStyles.polyline,
        rectangle: false,
      },
      edit: { featureGroup: this.editableGeometryFeature },
    }
    return this.editControls = new L.Control.Draw(editControls)
  },
  bindDrawEvents: function() {
    this.map.on('draw:created', function (e) {
      switch(e.layerType) {
        case 'marker':
          this.persistMarker(e.layer)
          this.updateMarkerInput(this.editableGeometryFeature.getLayers())
          break
        case 'polygon':
          this.persistPolygon(e.layer)
          this.updatePolygonInput(this.editableGeometryFeature.getLayers())
          break
        case 'polyline':
          this.persistPolyline(e.layer)
          this.updatePolylineInput(this.editableGeometryFeature.getLayers())
          break
      }
      this.createControls && this.map.removeControl(this.createControls)
      this.editControls && this.map.removeControl(this.editControls);
      this.map.addControl(this.generateEditControls());
    }.bind(this))
    this.map.on('draw:editstop', function (e) {
      var layers = this.editableGeometryFeature.getLayers()
      var areMarkers = layers[0] instanceof L.Marker
      var arePolygons = layers[0] instanceof L.Polygon
      var arePolylines = layers[0] instanceof L.Polyline
      if (areMarkers) {this.updateMarkerInput(layers); return}
      if (arePolygons) {this.updatePolygonInput(layers); return}
      if (arePolylines) {this.updatePolylineInput(layers); return}
    }.bind(this))
    this.map.on("draw:deletestop", function(e) {
      var layers = this.editableGeometryFeature.getLayers()
      var areMarkers = layers[0] instanceof L.Marker
      var arePolygons = layers[0] instanceof L.Polygon
      var arePolylines = layers[0] instanceof L.Polyline
      if (areMarkers) {this.updateMarkerInput(layers); return}
      if (arePolygons) {this.updatePolygonInput(layers); return}
      if (arePolylines) {this.updatePolylineInput(layers); return}

      if (lastGeometry(this.editableGeometryFeature)) {
        this.featureType = null
        this.editControls && this.map.removeControl(this.editControls)
        this.map.addControl(this.generateCreateControls());
      }
      function lastGeometry(geom) {return geom.getLayers().length == 0}
    }.bind(this));
  },
  centerMap: function(polygon) {
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
  hasBaseGeometry: function () {
    return !_.isEmpty(this.base)
  },
  hasEditableGeometry: function () {
    return !_.isEmpty(this.editable)
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
  persistMarker: function(layer) {
    layer.addTo(this.editableGeometryFeature);
  },
  persistPolygon: function(layer) {
    layer.addTo(this.editableGeometryFeature);
  },
  persistPolyline: function(layer) {
    layer.addTo(this.editableGeometryFeature);
  },
  setAccessToken: function(token) {
    L.mapbox.accessToken = token
  },
  setInputs: function() {
    this.inputGeometry = $('.geometry-field')
    this.inputGeo_geometry = $('.geo_geometry-field')
    if(this.hasEditableGeometry()) {
      var geoJsonGeometry = (new L.Polyline(this.editable.coordinates)).toGeoJSON()
      if (this.editable.type == 'marker') geoJsonGeometry.geometry.type = 'MultiPoint'
      var WKTGeometry = wellknown.stringify(geoJsonGeometry)

      this.inputGeometry.val(WKTGeometry)
      this.inputGeo_geometry.val(WKTGeometry)
      this.featureType = this.editable.type
    }
  },
  setMapContainer: function(selector) {
    this.mapContainer = this.$el.find(selector)
  },
  showBaseGeometry: function() {
    if (!this.hasBaseGeometry()) return
    this.showPolygon(this.base, {fixed: true})
  },
  showEditableGeometry: function() {
    if (!this.hasEditableGeometry()) return
    switch (this.editable.type) {
      case 'marker':
        this.showMarker(this.editable)
        break
      case 'polygon':
        this.showPolygon(this.editable)
        break
      case 'polyline':
        this.showPolyline(this.editable)
        break
    }
  },
  showMarker: function(marker) {
    var points =  marker.coordinates[0] instanceof Array ? marker.coordinates : [marker.coordinates]
    points.forEach(function(point) {
      new L.Marker(point, {
        icon: L.icon({
          className: "geometry-marker",
          iconAnchor: [20, 30],
          iconSize: [40, 40],
          iconUrl: marker.icon,
          shadowAnchor: [19, 29],
          shadowSize: [40, 40],
          shadowUrl: this.markerShadowURL,
        }
      )}).addTo(this.editableGeometryFeature)
    }.bind(this))
  },
  showPolygon: function(polygon, options) {
    var parent = options && options.fixed ? this.baseGeometryFeature : this.editableGeometryFeature
    var polygons =  polygon.coordinates[0][0] instanceof Array ? polygon.coordinates : [polygon.coordinates]
    polygons.forEach(function(_polygon) {
      new L.Polygon(_polygon,
        {
          className: "geometry-polygon " + polygon.className,
        }).addTo(parent)
    })
  },
  showPolyline: function(polyline, options) {
    var parent = options && options.fixed ? this.baseGeometryFeature : this.editableGeometryFeature
    var polylines =  polyline.coordinates[0][0] instanceof Array ? polyline.coordinates : [polyline.coordinates]
    polylines.forEach(function(_polyline) {
      new L.Polyline(_polyline,
        {
          className: "geometry-polyline " + polyline.className,
        }).addTo(parent)
    })
  },
  updateMarkerInput: function(layers) {
    window.la = layers
    var points = layers.map(function(layer) { return layer.getLatLng() || layer.getLatLngs() })
    var new_point_geojson = (new L.Polyline(points)).toGeoJSON()
    new_point_geojson.geometry.type = "MultiPoint"
    var point = wellknown.stringify(new_point_geojson)
    this.inputGeometry.val(point)
    this.inputGeo_geometry.val(point)
    this.featureType = 'marker'
  },
  updatePolygonInput: function(layers) {
    var polygons = layers.map(function(layer) { return layer.getLatLngs() })
    var new_polygon_geojson = (new L.Polygon(polygons)).toGeoJSON()
    var polygon = wellknown.stringify(new_polygon_geojson)
    this.inputGeometry.val(polygon)
    this.inputGeo_geometry.val(polygon)
    this.featureType = 'polygon'
  },
  updatePolylineInput: function(layers) {
    var polylines = layers.map(function(layer) { return layer.getLatLngs() })
    var new_polyline_geojson = (new L.Polyline(polylines)).toGeoJSON()
    var polyline = wellknown.stringify(new_polyline_geojson)
    this.inputGeometry.val(polyline)
    this.inputGeo_geometry.val(polyline)
    this.featureType = 'polyline'
  },
  zoomMap: function(polygon) {
    if (_.isEmpty(polygon)) return
    var bounds = this.getBounds(polygon)
    this.map.fitBounds([[bounds.min.x, bounds.min.y], [bounds.max.x, bounds.max.y]], {animate: false})
  },
})
