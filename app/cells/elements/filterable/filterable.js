CDLV.Components['elements/filterable'] = Backbone.View.extend({
  events: {
    'click .filter-button': 'filter_button',
  },
  initialize: function(options) {
    _.bindAll(
      this,
      'filter_button'
    )
    this.filter_menu = this.$el.find('.filter-list')
  },
  filter_button: function() {
    this.filter_menu.toggleClass('opened')
  }
})
