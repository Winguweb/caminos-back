CDLV.Components['elements/alert'] = Backbone.View.extend({
  initialize: function(options) {
    _.bindAll(
        this,
        'alertShow'
    )
    this.action = options.action
    CDLV.pubSub.on({
      'alert:show': this.alertShow,
    })
  },
  alertShow: function(action) {
    var confirm = window.confirm(action.message)
    action.cb(this.$el, confirm)
    return false
  }
})
