CDLV.Components['user_header_menu'] = Backbone.View.extend({
  events: {
    'click .user-menu': 'clickUserMenu',
  },
  initialize: function(options) {
    _.bindAll(
        this,
        'clickUserMenu',
        'openUserMenu'
    )

    this.userMenuElement = this.$el.find('.user-menu')

    CDLV.pubSub.on({
      'user-menu:show': this.openUserMenu,
    })

  },
  clickUserMenu: function(evt) {
    CDLV.pubSub.trigger('user-menu:show')
  },
  openUserMenu: function(evt) {
    this.userMenuElement.toggleClass('user-menu--opened')
  },
})
