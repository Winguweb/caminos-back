CDLV.Components['page/public_header'] = Backbone.View.extend({
  events: {
    'change select' : 'neighborhoodChanged'
  },
  initialize: function(options) {
    _.bindAll(
      this,
      'neighborhoodChanged'
    )

    this.$el.find('select').selectize()

  },
  neighborhoodChanged: function(ev) {
    var value = ev.target.value
    if (!value) return
    if (value == '_all') {
      window.location = '/barrios'
      return
    }
    window.location = '/barrios/' + value
  }

})
