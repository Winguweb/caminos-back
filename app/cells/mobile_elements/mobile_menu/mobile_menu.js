CDLV.Components['mobile_elements/mobile_menu'] = Backbone.View.extend({
  events: {
    'click button': 'showMenu',
  },
  initialize: function(options) {


  },
  showMenu: function() {
    this.$el.toggleClass('opened');
  }
})
