CDLV.Components['elements/file_uploader_preview'] = Backbone.View.extend({
  initialize: function(options){
    _.bindAll(
        this,
        'namespaced',
        'createThumbnail',
        'uploadComplete',
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
      [ns(this.namespace + ':photo:uploaded', inputId)]: this.uploadComplete,
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

    var $thumbnailLoader = $('<div><div class="loading-spinner indeterminate"><svg focusable="false" preserveAspectRatio="xMidYMid meet" viewBox="0 0 100 100"><circle cx="50%" cy="50%" r="45" class="ng-star-inserted"></circle></svg></div></div>')

    $thumbnailLoader.addClass('thumbnail-loader')

    var $thumbnailWrapper = $('<div></div>')
    $thumbnailWrapper.addClass('thumbnail-wrapper')

    $thumbnailWrapper.append($thumbnail, $thumbnailLoader)
    this.$el.append($thumbnailWrapper)
  },
  updateImage: function(hash, image) {
    this.$el.find('[data-hash="' + hash + '"]').attr('src', image)
  },
  uploadComplete: function(hash) {
    $thumbnailLoader = this.$el.find('[data-hash="' + hash + '"]').next()
    $thumbnailLoader.addClass('hide')
  }
})
