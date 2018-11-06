CDLV.Components['map_references'] = Backbone.View.extend({
  initialize: function(options) {
    _.bindAll(
      this,
      'onEachFeature'
    )

    this.loadDefaults(options)
    this.setAccessToken()
    this.createMap()
    this.configureMapForMobile()
    this.showBaseGeometry()
    this.centerMap()
  },
  centerMap: function() {
    this.map.fitBounds(this.baseGeometryFeature.getBounds())
  },
  configureMapForMobile: function() {
    if ($('html').hasClass('touchevents')) {this.map.dragging.disable()}
  },
  createMap: function() {
    var mapContainer = this.$el.find('#map-container')[0]
    this.map = L.mapbox.map(mapContainer, this.style, {scrollWheelZoom: false, maxZoom: 18})
    L.mapbox.styleLayer('mapbox://styles/juanlacueva/cjn4oy3d40mfz2rnn6z5bngy1').addTo(this.map);
    this.baseGeometryFeature = new L.FeatureGroup()
    this.map.addLayer(this.baseGeometryFeature)
  },
  featureClickListener: function(feature) {
    return function() { window.location = feature.properties.url }
  },
  featureMouseoverListener: function(feature) {
    var _this = this
    return function(evt) {
      var urbanizationLegend = I18n.t('js.neighborhoods.popup.' + feature.properties.urbanization_process)
      var name = feature.properties.name
      var monitorLinkLegend = I18n.t('js.neighborhoods.popup.links.monitor')
      var assetLinkLegend = I18n.t('js.neighborhoods.popup.links.asset')
      var claimLinkLegend = I18n.t('js.neighborhoods.popup.links.claim')
      var urbanizationProcess = feature.properties.urbanization_process
      var nameTag = '<p>' + name + '</p>'
      var statusTag = '<span class="status-' + urbanizationProcess + '">' + urbanizationLegend + '</span>'
      var monitorLinkTag = '<a href="' + feature.properties.url + '">' + monitorLinkLegend + '</a>'
      var assetLinkTag = '<a href="' + feature.properties.asset_url + '">' + assetLinkLegend + '</a>'
      var claimLinkTag = '<a href="' + feature.properties.claim_url + '">' + claimLinkLegend + '</a>'
      var linksTag = '<div>' + monitorLinkTag + '</div><div>' + assetLinkTag + claimLinkTag + '</div>'
      var popupOptions = {
        position: {left: evt.containerPoint.x + 'px', top: evt.containerPoint.y + 'px'},
        html: nameTag + linksTag
      }
      _this.showPopup(popupOptions)
    }
  },
  featureMouseoutListener: function() {
    var _this = this
    return function() {
      _this.hidePopup()
    }
  },
  hidePopup: function() {
    var _this = this
    this.popupTimeout = setTimeout(function() {
      _this.popup.removeClass('visible')
    }, 300)
  },
  loadDefaults: function(options) {
    this.base = options.base
    this.center = options.defaults.center
    this.style = options.defaults.style
    this.token = options.token
    this.zoom = options.defaults.zoom
  },
  onEachFeature: function(feature, layer){
    var _this = this
    if (['MultiPolygon', 'Polygon'].indexOf(feature.geometry.type) > -1 ) {
      var icon = new L.divIcon({
        html: '<div><p class="marker-name ' + feature.properties.className + '">' + feature.properties.name + '</p><p class="reference-marker ' + feature.properties.className + '"><span>' + feature.properties.abbreviation + '</span></p></div>',
      })
      var centroid = turf.centroid(feature);
      var coordinates = new L.latLng(
        centroid.geometry.coordinates[1],
        centroid.geometry.coordinates[0]
      )

      layer.options.opacity = 0
      layer.options.fill = false

      var marker = L.marker(coordinates, {icon: icon})
      marker.on('click', _this.featureClickListener(feature))
      marker.on('mouseover', _this.featureMouseoverListener(feature))
      marker.on('mouseout', _this.featureMouseoutListener(feature))
      marker.addTo(this.map)
    }
  },
  setAccessToken: function() {
    L.mapbox.accessToken = this.token
  },
  showBaseGeometry: function() {
    var geoJSONFunctions = { onEachFeature: this.onEachFeature }
    var geoJSON = L.geoJSON(this.base, geoJSONFunctions)
    geoJSON.addTo(this.baseGeometryFeature)
  },
  showPopup: function(options) {
    clearTimeout(this.popupTimeout)
    this.popup = this.popup || $('<div class="map-reference-popup"></div>').appendTo(this.$el)
    this.popup.css(options.position)
    this.popup.html(options.html)
    this.popup.addClass('visible')
  },
})
