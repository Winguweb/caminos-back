CDLV.Components['elements/toast'] = Backbone.View.extend({
  events: {
    'click .toast-cell': 'buttonTrigger',
  },
  initialize: function(options) {
    _.bindAll(
        this,
        'buttonTrigger',
        'hideComponent'
    )
    this.el = options.el
    setTimeout(this.hideComponent, 1000)
  },
  buttonTrigger: function(trigger) {
    var type = this.action.type
    var action = this.action
    CDLV.pubSub.trigger(type, action)
    return false
  },
  hideComponent: function() {
    console.log(this.el)
    this.el.addClass('hidden')
  }
})
