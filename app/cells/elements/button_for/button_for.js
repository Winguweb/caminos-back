CDLV.Components['button_for'] = Backbone.View.extend({
  events: {
    'click': 'labelClicked',
  },
  initialize: function(options) {

    _.bindAll(
        this,
        'labelClicked'
    )

    this.element = $('#' + options.for.id).siblings('.jFiler-input')
  },
  labelClicked: function(evt) {
    evt.preventDefault()
    this.element.click()
  }
})
