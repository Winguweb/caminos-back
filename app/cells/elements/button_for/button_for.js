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

    CDLV.pubSub.on({
      'filer:upload:before': this.beforeUpload,
      'filer:upload:error': this.uploadError,
      'filer:upload:success': this.uploadSuccess,
      'filer:remove': this.removeFile
    })
  },
  labelClicked: function(evt) {
    evt.preventDefault()
    this.element.click()
  }
})
