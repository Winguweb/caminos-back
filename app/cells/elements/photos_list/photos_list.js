CDLV.Components['photos/list'] = Backbone.View.extend({
  initialize: function(options){
    _.bindAll(
      this,
      'addPhoto',
      'removePhoto'
    )
    var $template = this.$el.find('#photo-template')
    this.template = _.template($template.html())
    $template.remove()

    CDLV.pubSub.on({
      'photo:add': this.addPhoto,
      'photo:remove': this.removePhoto
    })
  },

  addPhoto: function(data){
    this.$el.append( this.template(data.response) )
  },

  removePhoto: function(photoId){
    this.$el.find('#'+photoId).remove()
  }
})
