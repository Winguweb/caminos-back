CDLV.Components['elements/file_uploader_preview'] = Backbone.View.extend({
  initialize: function(options){
    _.bindAll(
      this,
      'namespaced',
      'createThumbnail',
      'uploadComplete',
      'updateImage',
      'removePhoto',
      'findThumbnailByHash'
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
    var _this = this

    var $thumbnail = $('<img src="" alt="" />')
    $thumbnail.attr('alt', fileObject.filename)
    $thumbnail.attr('title', fileObject.filename)
    $thumbnail.attr('src', '/assets/thumbnail.svg')
    $thumbnail.attr('data-hash', fileObject.hash)

    var $thumbnailLoader = $('<div class="thumbnail-loader"><div class="loading-spinner indeterminate"><svg focusable="false" preserveAspectRatio="xMidYMid meet" viewBox="0 0 100 100"><circle cx="50%" cy="50%" r="45" class="ng-star-inserted"></circle></svg></div></div>')

    var $thumbnailActions = $('<div class="thumbnail-actions"></div>')

    var $thumbnailActionRemove = $('<a class="thumbnail-action action-remove" href="#"><i></i><span>Eliminar</span></a>')
    $thumbnailActionRemove.click(function(evt) { evt.preventDefault(); _this.removePhoto(fileObject.hash, $thumbnailActionRemove.data('id')) })

    var $thumbnailWrapper = $('<div class="thumbnail-wrapper"></div>')

    $thumbnailActions.append($thumbnailActionRemove)

    $thumbnailWrapper.append($thumbnail, $thumbnailLoader, $thumbnailActions)

    this.$el.append($thumbnailWrapper)
  },
  updateImage: function(fileObject, image) {
    this.$el.find('[data-hash="' + fileObject.hash + '"]').attr('src', image)
  },
  uploadComplete: function(hash, id) {
    $thumbnail = this.findThumbnailByHash(hash)
    $thumbnailLoader = $thumbnail.siblings('.thumbnail-loader')
    $thumbnailLoader.addClass('hide')
    $thumbnailActionRemove = $thumbnail.siblings('.thumbnail-actions').find('.action-remove')
    $thumbnailActionRemove.attr('data-id', id)
  },
  removePhoto: function(hash, id) {
    if (!id) return false
    if (!this.alertBeforeRemove()) return false

    var event = this.namespaced('file:uploader:photo:remove', this.inputId)
    CDLV.pubSub.trigger(event, id)

    $thumbnailWrapper = this.findThumbnailByHash(hash).parent('.thumbnail-wrapper')
    $thumbnailWrapper.fadeOut(600, function() { this.remove() })
  },
  findThumbnailByHash: function(hash) {
    return this.$el.find('[data-hash="' + hash + '"]')
  },
  alertBeforeRemove: function() {
    return confirm('¿Seguro que deseas eliminar este archivo?')
  }
})
