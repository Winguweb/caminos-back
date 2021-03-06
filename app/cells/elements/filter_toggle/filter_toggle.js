CDLV.Components['elements/filter_toggle'] = Backbone.View.extend({
  events: {
  'click a': 'changeFilter',
  },
  initialize: function(options) {
    _.bindAll(
        this,
        'changeFilter'
    )

  },
  changeFilter: function(ev) {
    var clicked = $(ev.currentTarget)
    var filter_name = clicked.data('filter')
    this._filterStyles(clicked)
    this._filterEmit(filter_name)
  },
  _filterStyles: function(clicked) {
    var all = this.$el.find('a')
    all.parent().removeClass('active')
    clicked.parent().addClass('active')
  },
  _filterEmit: function(filter_name) {
    CDLV.pubSub.trigger('filter-toggle:changed:status', filter_name)
    CDLV.pubSub.trigger('map-show:filter:status', filter_name)
  }
})

