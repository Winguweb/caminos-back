CDLV.Components['elements/toast'] = Backbone.View.extend({
  events: {
    'click .toast-cell': 'buttonTrigger',
  },
  initialize: function(options) {
    _.bindAll(
        this,
        'buttonTrigger',
        'hideComponent',
        'showComponent'
    )
    setTimeout(this.showComponent, 0)
    // setTimeout(this.hideComponent, 10000)
  },
  buttonTrigger: function(trigger) {
    var type = this.action.type
    var action = this.action
    CDLV.pubSub.trigger(type, action)
    return false
  },
  showComponent: function() {
    this.$el.removeClass('toast-hidden').addClass('toast-visible')
  },
  hideComponent: function() {
    this.$el.removeClass('toast-visible').addClass('toast-hidden')
  }
})
