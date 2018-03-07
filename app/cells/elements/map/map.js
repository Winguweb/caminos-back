CDLV.Components['map'] = Backbone.View.extend({
  initialize: function(options){
    L.mapbox.accessToken = 'pk.eyJ1IjoianVhbmxhY3VldmEiLCJhIjoiRFh4T2xVZyJ9.EUqU8kwG9NutFNdVdL2JdQ'

    var mapContainer = this.$el.find('#map-container')
    var map = L.mapbox.map(mapContainer[0], 'mapbox.streets')

    new L.Polygon(options.polygon).addTo(map)

    var points = options.polygon.map(function(point) {
      return new L.Point(point[0], point[1])
    })

    var bounds = new L.Bounds(points)
    var center = bounds.getCenter()

    map.setView([center.x, center.y], 14);
  }
})
