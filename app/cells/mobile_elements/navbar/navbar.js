CDLV.Components['mobile_elements/navbar'] = Backbone.View.extend({
  events: {
    'click': 'showMenu',
  },
  initialize: function(options) {


  },
  showMenu: function() {
    this.$el.toggleClass('opened');
  }
})
