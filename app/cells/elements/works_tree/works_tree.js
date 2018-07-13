CDLV.Components['works/tree'] = Backbone.View.extend({
  events: {
  'click .open-list-button': 'toggleList',
  },
  initialize: function(options) {
    _.bindAll(
        this,
        'toggleList'
    )
  },
  toggleList: function(ev) {
    var target = $(ev.currentTarget)
    var list = target.parent().next('ul')
    target.toggleClass('opened')
    list.toggleClass('opened')
  },
})
