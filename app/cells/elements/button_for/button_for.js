CDLV.Components['button_for'] = Backbone.View.extend({
  events: {
    'click': 'labelClicked',
  },
  initialize: function(options) {
    _.bindAll(
      this,
      'labelClicked'
    )
    this.element = $('#' + options.for.id)
  },

  labelClicked: function(evt) {
    evt.preventDefault()
    this.element.click()
  }
})
