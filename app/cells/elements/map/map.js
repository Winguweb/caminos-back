CDLV.Components['map'] = Backbone.View.extend({
  initialize: function(options){
    L.mapbox.accessToken = 'pk.eyJ1IjoianVhbmxhY3VldmEiLCJhIjoiRFh4T2xVZyJ9.EUqU8kwG9NutFNdVdL2JdQ'

    var center = {x: -34.6083, y: -58.3712}
    var default_zoom = 10
    var mapContainer = this.$el.find('#map-container')
    var map = L.mapbox.map(mapContainer[0], 'mapbox.streets', /*{drawControl: true}*/)
    var input_geometry = this.$el.find('.geometry')
    var input_geo_geometry = this.$el.find('.geo_geometry')
    var markers = options.markers

    if (options.set_polygon) {
      var drawnItems = new L.featureGroup();
       var drawControl = new L.Control.Draw({
           edit: {
               featureGroup: drawnItems
           }
       });
       map.addControl(drawControl);

      map.on('draw:created', function (e) {
          map.addLayer(e.layer);
          var latLngs = e.layer.getLatLngs()
          var new_polygon = new L.Polygon(latLngs)
          // var coordinates = evt.latlng
          // var point = new L.Point(coordinates.lat, coordinates.lng)
          // set_marker(map, coordinates)
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
      // var copypoint = option.polygon;
      // var x;
      // for(x = 0; x < copypoint.length; x++)
      // {
      //     vertices[x].replace(', ', ' ');
      // }

      // var new_polygon_points_string = options.polygon.join(', ')
      //     new_polygon_string = "POLYGON" + " ((" + new_polygon_points_string +  "))"
      // console.log(new_polygon_string);
      // console.log(copypoint);
      // console.log(new_polygon_points_string);

      // input_geometry.val(new_polygon_string)
      // input_geo_geometry.val(new_polygon_string)
      var points = options.polygon.map(function(point) {
        return new L.Point(point[0], point[1])
      })
      var bounds = new L.Bounds(points)
      center = bounds.getCenter()
      default_zoom = 14
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

    map.setView([center.x, center.y], default_zoom);
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
