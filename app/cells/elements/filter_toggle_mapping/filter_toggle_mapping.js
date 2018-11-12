CDLV.Components['elements/filter_toggle_mapping'] = Backbone.View.extend({
  events: {
  'click a': 'changeFilter',
  },
  initialize: function(options) {
    _.bindAll(
        this,
        'changeFilter'
    )

    setTimeout(function() {
      CDLV.pubSub.trigger('map-show:filter:class', 'Asset')
    }, 0)
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
    CDLV.pubSub.trigger('filter-toggle:changed:class', filter_name)
    CDLV.pubSub.trigger('map-show:filter:class', filter_name)
    CDLV.pubSub.trigger('citizen-participation:add', filter_name)
  }
})

