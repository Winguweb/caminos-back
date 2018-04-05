CDLV.Components['map_edit'] = Backbone.View.extend({
  initialize: function(options){
    var mapContainer = this.$el.find('#map-container')
    var input_geometry = this.$el.find('.geometry')
    var input_geo_geometry = this.$el.find('.geo_geometry')

    L.mapbox.accessToken = options.token

    var center = options.defaults.center
    var zoom = options.defaults.zoom
    var markers = options.markers

    var map = L.mapbox.map(mapContainer[0], 'mapbox.streets')

    if (options.set_polygon) {
      var controls = {
        position: 'topright',
        draw: {
          polyline: {
            shapeOptions: {
              color: '#f357a1',
              weight: 10
            }
          },
          polygon: {
            allowIntersection: false, // Restricts shapes to simple polygons
            drawError: {
              color: '#e1e100', // Color the shape will turn when intersects
              message: '<strong>Oh snap!<strong> you can\'t draw that!' // Message that will show when intersect
            },
            shapeOptions: {
              color: '#bada55'
            }
          },
          circle: false, // Turns off this drawing tool
          rectangle: {
            shapeOptions: {
              clickable: false
            }
          },
          marker: false
        },
      };

      var drawControl = new L.Control.Draw(controls);
      map.addControl(drawControl);

      map.on('draw:created', function (e) {
        map.addLayer(e.layer);
        var latLngs = e.layer.getLatLngs()
        var new_polygon = new L.Polygon(latLngs)
        var new_polygon_geojson = new_polygon.toGeoJSON()
        var new_polygon_type = new_polygon_geojson.geometry.type.toUpperCase()
        var new_polygon_points = []
        var points = new_polygon_geojson.geometry.coordinates[0]
        for (var i in points) {
          var point = points[i]
          new_polygon_points.push(point[0] + " " + point[1])
        }

        var new_polygon_points_string = new_polygon_points.join(', ')
        new_polygon_string = new_polygon_type + " ((" + new_polygon_points_string +  "))"
        input_geometry.val(new_polygon_string)
        input_geo_geometry.val(new_polygon_string)
      });
    }


    if (options.polygon.length > 0) {
      new L.Polygon(options.polygon).addTo(map)
      var copypoint = options.polygon;
      var new_polygon_points = []

      for (var i in copypoint) {
        var point = copypoint[i];
        new_polygon_points.push(point[1] + " " + point[0]);

      }
      var new_polygon_points_string =  new_polygon_points.join(', ');

      new_polygon_string = "POLYGON" + " ((" + new_polygon_points_string +  "))"

      input_geometry.val(new_polygon_string)
      input_geo_geometry.val(new_polygon_string)
      var points = options.polygon.map(function(point) {
        return new L.Point(point[0], point[1])
      })
      var bounds = new L.Bounds(points)
      center = bounds.getCenter()
      zoom = 14
    }

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
