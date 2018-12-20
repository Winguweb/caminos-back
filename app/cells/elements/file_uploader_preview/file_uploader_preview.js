CDLV.Components['elements/file_uploader_preview'] = Backbone.View.extend({
  initialize: function(options){
    _.bindAll(
        this,
        'namespaced',
        'createThumbnail',
        'updateImage',
    )

    this.namespace = 'file:uploader:preview'
    var _this = this
    var tg = this.trigger.bind(this)
    var ns = this.namespaced
    var inputId = this.inputId = options.id

    CDLV.pubSub.on({
      [ns(this.namespace + ':thumb:new', inputId)]: this.createThumbnail,
      [ns(this.namespace + ':thumb:end', inputId)]: this.updateImage,
    })
  },
  namespaced: function(action, channel) {
    return action + '/' + channel
  },
  createThumbnail: function(fileObject) {
    var $thumbnail = $('<img src="" alt="" />')
    $thumbnail.attr('alt', fileObject.filename)
    $thumbnail.attr('title', fileObject.filename)
    $thumbnail.attr('src', '/assets/thumbnail.svg')
    $thumbnail.attr('data-hash', fileObject.hash)

    var $thumbnailLoader = $('<div>...</div>')
    $thumbnailLoader.addClass('thumbnail-loader')

    var $thumbnailWrapper = $('<div></div>')
    $thumbnailWrapper.addClass('thumbnail-wrapper')

    $thumbnailWrapper.append($thumbnail, $thumbnailLoader)
    this.$el.append($thumbnailWrapper)
  },
  updateImage: function(hash, image) {
    this.$el.find('[data-hash="' + hash + '"]').attr('src', image)
  }
})

// CDLV.pubSub.on('all', function(data, d){console.info(data, d)})
