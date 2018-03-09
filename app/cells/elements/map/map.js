CDLV.Components['map'] = Backbone.View.extend({
  initialize: function(options){
    L.mapbox.accessToken = 'pk.eyJ1IjoianVhbmxhY3VldmEiLCJhIjoiRFh4T2xVZyJ9.EUqU8kwG9NutFNdVdL2JdQ'

    var mapContainer = this.$el.find('#map-container')
    var map = L.mapbox.map(mapContainer[0], 'mapbox.streets')
    var input_geometry = this.$el.find('.geometry')
    var input_geo_geometry = this.$el.find('.geo_geometry')
    var markers = options.markers
    new L.Polygon(options.polygon).addTo(map)


    for (var marker of markers) {
      new L.Marker(marker, {icon: L.mapbox.marker.icon({'marker-color': '#f86767'})}).addTo(map)
    }


    var points = options.polygon.map(function(point) {
      return new L.Point(point[0], point[1])
    })

    if (options.set_marker) {
      map.on('click', function(evt) {
        var coordinates = evt.latlng
        var point = new L.Point(coordinates.lat, coordinates.lng)
        set_marker(map, coordinates)
        input_geometry.val(point.toString().replace(',', ''))
        input_geo_geometry.val(point.toString().replace(',', ''))
      })
    }

    var bounds = new L.Bounds(points)
    var center = bounds.getCenter()

    map.setView([center.x, center.y], 14);
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
