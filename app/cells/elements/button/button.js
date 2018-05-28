CDLV.Components['elements/button'] = Backbone.View.extend({
  events: {
    ['click .button-cell']: 'buttonTrigger',
  },
  initialize: function(options) {
    _.bindAll(
        this,
        'buttonTrigger',
        'actionCallback'
    )

    if (!options.action) return
    this.action = options.action
    this.action.cb = this.actionCallback
    this.action.method = this.action.method || ''
  },
  buttonTrigger: function(trigger) {
    var type = this.action.type
    var action = this.action
    CDLV.pubSub.trigger(type, action)
    return false
  },
  actionCallback: function($el, response) {
    if (response) this.$el.find('form').submit()
  }
})
