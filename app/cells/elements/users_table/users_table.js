CDLV.Components['users/table'] = Backbone.View.extend({
  initialize: function(){
    this.$el.find('tr.user').each(function(key, item){
      new CDLV.Components['users/table/row']({
        el: item
      })
    });
  }
})

CDLV.Components['users/table/row'] = Backbone.View.extend({
  events:{
    'click': 'viewUser',
    'mouseenter': 'enterItem',
    'mouseleave': 'leaveItem',
  },

  viewUser: function(evt){
    var $target = $(evt.target)
    if( $target.is('a') || $target.is('button') ) return

    var $currentTarget = $(evt.currentTarget)
    var userUrl = '/admin/users/' + $currentTarget.data('id')
    var openNewWindow = evt.ctrlKey || evt.metaKey

    if( openNewWindow ){
      window.open(userUrl, '_blank')
    } else {
      window.location = userUrl
    }
  },

  enterItem: function(){
    this.$el.addClass('on-focus')
  },
  leaveItem: function(){
    this.$el.removeClass('on-focus')
  },
})
