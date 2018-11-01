CDLV.Components['map_show'] = Backbone.View.extend({
  initialize: function(options) {
    _.bindAll(
      this,
      'changeCategoryFilter',
      'changeStatusFilter'
    )

    this.loadDefaults(options)
    this.setAccessToken()
    this.createMap()
    this.configureMapForMobile()
    this.showBaseGeometry()
    this.showFeaturesGeometry()
    this.centerMap()

    CDLV.pubSub.on({
      'map-show:filter:category': this.changeCategoryFilter,
      'map-show:filter:status': this.changeStatusFilter
    })
  },
  centerMap: function() {
    this.map.fitBounds(this.baseGeometryFeature.getBounds())
  },
  changeCategoryFilter: function(categoryName) {
    this.categoryFilter = categoryName
    this.baseGeometryFeature.clearLayers()
    this.showBaseGeometry()
    this.showFeaturesGeometry()
  },
  changeStatusFilter: function(statusName) {
    this.statusFilter = statusName
    this.categoryFilter = null
    this.baseGeometryFeature.clearLayers()
    this.showBaseGeometry()
    this.showFeaturesGeometry()
  },
  configureMapForMobile: function() {
    if ($('html').hasClass('touchevents')) {this.map.dragging.disable()}
  },
  createIcon: function(icon) {
    return L.icon({
      className: "geometry-marker",
      iconAnchor: [20, 30],
      iconSize: [40, 40],
      iconUrl: icon,
      shadowAnchor: [19, 29],
      shadowSize: [40, 40],
      shadowUrl: this.markerShadowURL,
    })
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
      var statusLegend = I18n.t('js.works.popup.status.' + feature.properties.status)
      var name = feature.properties.name
      var status = feature.properties.status
      var popupOptions = {
        position: {left: evt.containerPoint.x + 'px', top: evt.containerPoint.y + 'px'},
        html: '<p>' + name + '</p><span class="status-' + status + '">' + statusLegend + '</span>'
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
  filterFeatures: function() {
    var _this = this
    if (this.features.features) {
      return {
        type: "FeatureCollection",
        features: _this.features.features.filter(function(feature) {
          passCategoryFilter = (feature.properties.category == _this.categoryFilter) || !_this.categoryFilter
          passStatusFilter = (feature.properties.status == _this.statusFilter) || !_this.statusFilter
          return passCategoryFilter && passStatusFilter
        })
      }
    }
    return {type: "FeatureCollection", features: []}
  },
  hidePopup: function() {
    this.popup.removeClass('visible')
  },
  loadDefaults: function(options) {
    this.base = options.base
    this.features = options.features
    this.center = options.defaults.center
    this.style = options.defaults.style
    this.token = options.token
    this.zoom = options.defaults.zoom
  },
  setAccessToken: function() {
    L.mapbox.accessToken = this.token
  },
  showBaseGeometry: function() {
    var options = {
      style: {
        className: "base-geometry"
      }
    }
    L.geoJSON(this.base, options).addTo(this.baseGeometryFeature)
  },
  showFeaturesGeometry: function() {
    var _this = this
    var options = {
      style: function(feature) {
        var category = feature.properties.category
        var geometryType = feature.geometry.type
        var className = "geometry-work " + category + " " + geometryType
        return {
          className: className,
          status: feature.properties.status
        }
      },
      pointToLayer: function(feature, latLng) {
        return L.marker(latLng, {icon: _this.createIcon(feature.properties.icon)})
      },
      onEachFeature: function(feature, layer) {
        layer.on({
          click: _this.featureClickListener(feature),
          mouseover: _this.featureMouseoverListener(feature),
          mouseout: _this.featureMouseoutListener()
        })
      }
    }

    L.geoJSON(this.filterFeatures(), options).addTo(this.baseGeometryFeature)
  },
  showPopup: function(options) {
    this.popup = this.popup || $('<div class="map-show-popup"></div>').appendTo(this.$el)
    this.popup.css(options.position)
    this.popup.html(options.html)
    this.popup.addClass('visible')
  },
})
