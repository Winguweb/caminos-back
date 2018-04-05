CDLV.Components['map_edit'] = Backbone.View.extend({
  initialize: function(options) {

    _.bindAll(
      this,
      'setMapContainer',
      'hasPolygon',
      'hasMarker',
      'setAccessToken',
      'loadDefaults',
      'createMap',
      'showPolygons',
      'showMarker',
      'updateMarkerInput',
      'updatePolygonInput',
      'persistMarker',
      'persistPolygon',
      'centerMap',
      'getCenter',
      'addControls',
      'bindDrawEvents',
      'setInputs',
    )

    this.setAccessToken(options.token)

    this.setMapContainer('#map-container')

    this.loadDefaults(options)

    this.createMap()

    this.addControls()

    this.setInputs()

    this.bindDrawEvents()

    this.showPolygons()

    this.showMarker()

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
  hasMarker: function () {
    return !_.isEmpty(this.marker)
  },
  loadDefaults: function(options) {
    this.edit = options.edit
    this.center = options.defaults.center
    this.zoom = options.defaults.zoom
    this.style = options.defaults.style
    this.markerEditableURL = options.defaults.marker_editable_url
    this.markerShadowURL = options.defaults.marker_shadow_url
    this.marker = options.marker
    this.polygon = options.polygon
    this.geometryStyles = options.defaults.geometry_styles
    this.controls = options.controls
  },
  createMap: function() {
    this.map = L.mapbox.map(this.mapContainer[0], this.style)
    this.drawnGeometry = new L.FeatureGroup()
    this.map.addLayer(this.drawnGeometry)
  },
  showPolygons: function() {
    if (!this.hasPolygon()) return
    new L.Polygon(this.polygon).addTo(this.drawnGeometry)
    this.zoom = 14
  },
  showMarker: function() {
    if (!this.hasMarker()) return
    new L.Marker(this.marker.coordinates, {
      icon: L.icon({
        iconUrl: this.marker.icon,
        iconSize: [40, 40],
        iconAnchor: [20, 30],
        className: "marker",
        shadowUrl: this.markerShadowURL,
        shadowSize: [40, 40],
        shadowAnchor: [19, 29],
      }
    )}).addTo(this.drawnGeometry)
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
  },
  addControls: function() {
    var createControls = {
      position: 'topright',
      draw: {
        polyline: this.controls.polyline ? this.geometryStyles.polyline : false,
        polygon: this.controls.polygon ? this.geometryStyles.polygon : false,
        rectangle: this.controls.rectangle ? this.geometryStyles.rectangle : false,
        circle: this.controls.circle ? this.geometryStyles.circle : false,
        marker: this.controls.marker ? this.geometryStyles.marker : false,
        circlemarker: this.controls.circlemarker ? this.geometryStyles.circlemarker : false
      },
    }
    createControls.draw.marker.icon = L.icon(_.extend(createControls.draw.marker.icon, {
      iconUrl: this.markerEditableURL,
      shadowUrl: this.markerShadowURL,
    }))

    this.createControls = new L.Control.Draw(createControls)
    var editControls = _.extend({}, createControls, {
      draw: false,
      edit: {
        featureGroup: this.drawnGeometry
      }
    })

    this.editControls = new L.Control.Draw(editControls)

    this.map.addControl(this.edit ? this.editControls : this.createControls);
  },
  setInputs: function() {
    this.inputGeometry = this.$el.find('.geometry')
    this.inputGeo_geometry = this.$el.find('.geo_geometry')
    this.inputPolygon = this.$el.find('.polygon')
    this.inputGeo_polygon = this.$el.find('.geo_polygon')
    if(this.hasMarker()) {
      var coordinates = new L.Point(this.marker.coordinates[0],this.marker.coordinates[1])
      this.inputGeometry.val(coordinates.toString().replace(',', ''))
      this.inputGeo_geometry.val(coordinates.toString().replace(',', ''))
    }
    if(this.hasPolygon()) {
    }
  },
  bindDrawEvents: function() {
    this.map.on('draw:created', function (e) {
      this.layer = e.layer
      switch(e.layerType) {
        case 'polygon':
          this.persistPolygon(e.layer)
          break
        case 'marker':
          this.persistMarker(e.layer)
          break
      }
      this.map.removeControl(this.createControls)
      this.map.addControl(this.editControls);
    }.bind(this))
    this.map.on('draw:edited', function (e) {
      e.layers.eachLayer(function (layer) {
        if (layer instanceof L.Marker){
          this.updateMarkerInput(layer)
        }
        if (layer instanceof L.Polygon){
          this.persistPolygon(layer)
        }
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
    this.layer.addTo(this.drawnGeometry);
    this.updatePolygonInput(layer)
  },
  persistMarker: function(layer) {
    this.layer.addTo(this.drawnGeometry);
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
    this.inputPolygon.val(polygon)
    this.inputGeo_polygon.val(polygon)
  },
  geoJSONToWKT: function(geoJSON) {
    var geometryType = geoJSON.geometry.type.toUpperCase()
    var coordinates = geoJSON.geometry.coordinates[0].map(function(point) {
      return point[0] + " " + point[1]
    }).join(', ')
    return geometryType + " ((" + coordinates +  "))"
  }
})




CDLV.Components['_map_edit'] = Backbone.View.extend({
  initialize: function(options){




    for (var index in markers) {
      var marker = markers[index]
      new L.Marker(marker, {icon: L.mapbox.marker.icon({'marker-color': '#f86767'})}).addTo(map)
    }

    if (options.set_marker) {
      map.on('click', function(evt) {
        var coordinates = evt.latlng
        var point = new L.Point(coordinates.lat, coordinates.lng)
        set_marker(map, coordinates)
        input_geometry.val(point.toString().replace(',', ''))
        input_geo_geometry.val(point.toString().replace(',', ''))
      })
    }

    map.setView([center.x, center.y], zoom);
  }
})

function set_marker(map, coordinates) {
  if (map.new_marker) {
    return map.new_marker.setLatLng(coordinates)
  }

  new_marker = new L.Marker(coordinates, {icon: L.mapbox.marker.icon({'marker-color': '#f86767'})})
  map.new_marker = new_marker
  new_marker.addTo(map)
}
