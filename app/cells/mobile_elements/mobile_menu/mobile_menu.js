CDLV.Components['mobile_elements/mobile_menu'] = Backbone.View.extend({
  events: {
    'click .hamburguer-menu button': 'showMenu',
  },
  initialize: function(options) {


  },
  showMenu: function() {
    this.$el.toggleClass('opened');
  }
})
