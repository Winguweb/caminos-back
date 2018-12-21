CDLV.Components['elements/file_uploader'] = Backbone.View.extend({
  initialize: function(options){
    _.bindAll(
      this,
      'namespaced',
      'uploadSuccess',
      'removePhoto'
    )

    this.namespace = 'file:uploader'

    var _this = this
    var tg = this.trigger.bind(this)
    var ns = this.namespaced
    var inputId = this.inputId = options.id
    var inputName = this.inputName = options.name

    this.owner = options.owner

    this.on({
      [ns(this.namespace + ':before', inputId)]: this.beforeUpload,
      [ns(this.namespace + ':error', inputId)]: this.uploadError,
      [ns(this.namespace + ':select', inputId)]: this.selectFile,
      [ns(this.namespace + ':success', inputId)]: this.uploadSuccess,
    })

    CDLV.pubSub.on({
      [ns(this.namespace + ':photo:remove', inputId)]: this.removePhoto,
    })

    this.fileInput = this.$el.find('#' + inputId).filer({
      addMore: true,
      appendTo: '.photos-uploads',
      changeInput: true,
      extensions: ['jpg', 'jpeg', 'png'],
      fileMaxSize: 10,
      files: options.images || [],
      limit: 50,
      maxSize: 100,
      showThumbs: true,
      uploadFile: {
        enctype: 'multipart/form-data',
        synchron: false,
        type: 'POST',
        url: options.url,
        beforeSend: function(filerItem){ tg(ns(_this.namespace + ':before', inputId), filerItem) },
        error: function(filerItem){ tg(ns(_this.namespace + ':error', inputId), filerItem) },
        success: function(data, filerItem){ tg(ns(_this.namespace + ':success', inputId), data, filerItem) },
      },
      beforeShow: function(){ tg(ns(_this.namespace + ':add', inputId)); return true },
      onRemove: function(filerItem){ tg(ns(_this.namespace + ':remove'), filerItem); return true },
      onSelect: function(data, filerItem){ tg(ns(_this.namespace + ':select', inputId), data, filerItem); return true },
    }).prop("jFiler")
  },
  namespaced: function(action, channel) {
    return action + '/' + channel
  },
  selectFile: function(file, filerItem) {
    var _this = this
    var reader = new FileReader()
    var fileObject = {
      filename: file.name,
      size: file.size,
      type: file.type,
      lastModified: file.lastModified,
      hash: file.name + ';' + file.type + ';' + file.size + ';' + file.lastModified,
    }

    filerItem.attr('data-hash', fileObject.hash)

    reader.onloadstart = function(data) {
      var event = _this.namespaced('file:uploader:preview:thumb:new', _this.inputId)
      CDLV.pubSub.trigger(event, fileObject)
    }

    reader.onprogress = function(data) {
      var percentage = data.total == 0 ? 0 : data.loaded / data.total
      var event = _this.namespaced('thumbnail:load:progress', _this.inputId)
      CDLV.pubSub.trigger(event, percentage)
    }

    reader.onloadend = function(data) {
      var event = _this.namespaced('file:uploader:preview:thumb:end', _this.inputId)
      CDLV.pubSub.trigger(event, fileObject, data.target.result )
    }
    reader.readAsDataURL(file)
  },
  uploadSuccess: function(data, filerItem) {
    var event = this.namespaced('file:uploader:preview:photo:uploaded', this.inputId)
    var hash = filerItem.data('hash')
    CDLV.pubSub.trigger(event, hash, data.response.id)

    var $photoInput = $('<input />')
    $photoInput.attr('type', 'hidden')
    $photoInput.attr('name', this.inputName)
    $photoInput.val(data.response.id)
    this.$el.append($photoInput)
  },
  removePhoto: function(photoId) {
    var _this = this

    if( _.isEmpty(photoId) ) return true

    var url = '/ajax/files/' + photoId

    $.ajax({
      url: url,
      type: 'delete',
      cache: false,
    }).done(function(data){
      return true
    }).fail(function(xhr){
      return false
    })
  }
})
