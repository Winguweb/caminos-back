CDLV.Components['map_edit'] = Backbone.View.extend({
  initialize: function(options) {
    _.bindAll(
      this,
      'addControls',
      'bindDrawEvents',
      'centerMap',
      'createMap',
      'getCenter',
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
    )

    this.setAccessToken(options.token)

    this.setMapContainer('#map-container')

    this.loadDefaults(options)

    this.createMap()

    this.addControls()

    this.setInputs()

    this.bindDrawEvents()

    this.showBaseGeometry()

    this.showEditableGeometry()

    this.centerMap()
  },
  setAccessToken: function(token) {
    L.mapbox.accessToken = token
  },
  setMapContainer: function(selector) {
    this.mapContainer = this.$el.find(selector)
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
  createMap: function() {
    this.map = L.mapbox.map(this.mapContainer[0], this.style)
    this.editableGeometryFeature = new L.FeatureGroup()
    this.baseGeometryFeature = new L.FeatureGroup()
    this.map.addLayer(this.editableGeometryFeature)
    this.map.addLayer(this.baseGeometryFeature)
  },
  showBaseGeometry: function() {
    if (!this.hasBaseGeometry()) return
    this.showPolygon(this.base, {fixed: true, color: "#3388ff"})
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
    }
  },
  showPolygon: function(polygon, options) {
    var parent = options && options.fixed ? this.baseGeometryFeature : this.editableGeometryFeature
    new L.Polygon(polygon.coordinates).addTo(parent)
    this.zoom = 14
  },
  showMarker: function(marker) {
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
    )}).addTo(this.editableGeometryFeature)
  },
  centerMap: function() {
    var center = this.getCenter() || this.center
    this.map.setView([center.x, center.y], this.zoom);
  },
  getCenter: function() {
    var source = this.hasEditableGeometry() ? this.editable : this.base
    if (_.isEmpty(source)) return
    var points = source.coordinates.map(function(point) {
      return new L.Point(point[0], point[1])
    })
    var bounds = new L.Bounds(points)
    return bounds.getCenter()
  },
  addControls: function() {
    var createControls = {
      position: 'topright',
      draw: {
        circle: this.controls.circle ? this.geometryStyles.circle : false,
        circlemarker: this.controls.circlemarker ? this.geometryStyles.circlemarker : false,
        marker: this.controls.marker ? this.geometryStyles.marker : false,
        polygon: this.controls.polygon ? this.geometryStyles.polygon : false,
        polyline: this.controls.polyline ? this.geometryStyles.polyline : false,
        rectangle: this.controls.rectangle ? this.geometryStyles.rectangle : false,
      },
    }
    createControls.draw.marker.icon = L.icon(_.extend(createControls.draw.marker.icon, {
      iconUrl: this.markerEditableURL,
      shadowUrl: this.markerShadowURL,
    }))

    this.createControls = new L.Control.Draw(createControls)
    var editControls = _.extend({}, createControls, {
      draw: false,
      edit: { featureGroup: this.editableGeometryFeature },
    })

    this.editControls = new L.Control.Draw(editControls)

    this.map.addControl(this.hasEditableGeometry() ? this.editControls : this.createControls);
  },
  setInputs: function() {
    this.inputGeometry = $('.geometry-field')
    this.inputGeo_geometry = $('.geo_geometry-field')
    if(this.hasEditableGeometry()) {
      switch (this.editable.type) {
        case 'marker':
          var new_point_geojson = new L.Point(this.editable.coordinates[0][0],this.editable.coordinates[0][1])
          var geometry = new_point_geojson.toString().replace(',', '')
          break
        case 'polygon':
          var coordinates = this.editable.coordinates.map(function(latlng) {
            return new L.latLng(latlng[0], latlng[1])
          })
          var new_polygon_geojson = (new L.Polygon(coordinates)).toGeoJSON()
          var geometry = this.geoJSONToWKT(new_polygon_geojson)
          break
      }
      this.inputGeometry.val(geometry)
      this.inputGeo_geometry.val(geometry)
    }
  },
  bindDrawEvents: function() {
    this.map.on('draw:created', function (e) {
      switch(e.layerType) {
        case 'marker':
          this.persistMarker(e.layer)
          break
        case 'polygon':
          this.persistPolygon(e.layer)
          break
      }
      this.map.removeControl(this.createControls)
      this.map.addControl(this.editControls);
    }.bind(this))
    this.map.on('draw:edited', function (e) {
      e.layers.eachLayer(function (layer) {
        if (layer instanceof L.Marker) this.updateMarkerInput(layer)
        if (layer instanceof L.Polygon) this.persistPolygon(layer)
      }.bind(this));
      this.map.removeControl(this.createControls)
      this.map.addControl(this.editControls);
    }.bind(this))
    this.map.on("draw:deleted", function(e) {
      this.map.removeControl(this.editControls)
      this.map.addControl(this.createControls);
    }.bind(this));
  },
  persistPolygon: function(layer) {
    layer.addTo(this.editableGeometryFeature);
    this.updatePolygonInput(layer)
  },
  persistMarker: function(layer) {
    layer.addTo(this.editableGeometryFeature);
    this.updateMarkerInput(layer)
  },
  updateMarkerInput: function(layer) {
    var coordinates = new L.Point(layer._latlng.lat,layer._latlng.lng)
    this.inputGeometry.val(coordinates.toString().replace(',', ''))
    this.inputGeo_geometry.val(coordinates.toString().replace(',', ''))
  },
  updatePolygonInput: function(layer) {
    var new_polygon_geojson = (new L.Polygon(layer.getLatLngs())).toGeoJSON()
    var polygon = this.geoJSONToWKT(new_polygon_geojson)
    this.inputGeometry.val(polygon)
    this.inputGeo_geometry.val(polygon)
  },
  geoJSONToWKT: function(geoJSON) {
    var geometryType = geoJSON.geometry.type.toUpperCase()
    var coordinates = geoJSON.geometry.coordinates[0].map(function(point) {
      return point[0] + " " + point[1]
    }).join(', ')
    return geometryType + " ((" + coordinates +  "))"
  },
})