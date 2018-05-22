CDLV.Components['photos/uploader'] = Backbone.View.extend({
  initialize: function(options){
    _.bindAll(
        this,
        'addFile',
        'alert',
        'beforeUpload',
        'removeFile',
        'uploadError',
        'uploadSuccess'
    )

    var that = this
    var fileInputId = options.fileInputId || 'photo_image'
    var $form = this.$el.find('form')
    var $input = $form.find('#'+fileInputId)

    this.extraData = {}
    this.extraData[options.ownerData.name] = options.ownerData.value

    CDLV.pubSub.on({
      'filer:add': this.addFile,
      'filer:alert': this.alert,
      'filer:upload:before': this.beforeUpload,
      'filer:upload:error': this.uploadError,
      'filer:upload:success': this.uploadSuccess,
      'filer:remove': this.removeFile
    })

    this.filerInput = $input.filer({
      limit: 100,
      maxSize: 100,
      fileMaxSize: 10,
      extensions: ['jpg', 'jpeg', 'png'],
      changeInput: true,
      showThumbs: true,
      addMore: true,
      appendTo: '.photos-preview',
      dialogs: {
        alert: function(text) {
          return CDLV.pubSub.trigger('filer:alert', text)
        }
      },
      files: options.images || [],
      templates: {
        item: '<li class="jFiler-item" data-photo-id=""><div class="jFiler-item-container"><div class="jFiler-item-inner"><div class="jFiler-item-icon pull-left">{{fi-icon}}</div><div class="jFiler-item-info pull-left"><div class="jFiler-item-title" title="{{fi-name}}">{{fi-name | limitTo:30}}</div><div class="jFiler-item-others"><span>Tamaño: {{fi-size2}}</span><span>Tipo: {{fi-extension}}</span><span class="jFiler-item-status">{{fi-progressBar}}</span></div><div class="jFiler-item-assets"><ul class="list-inline"><li><a class="icon-jfi-trash jFiler-item-trash-action">' + I18n.t('js.filer.trash') + '</a></li></ul></div></div></div></div></li>',
        itemAppend: '<li class="jFiler-item jFiler-photo" data-photo-id="{{fi-phid}}"><div class="jFiler-photo-inner"><div class="jFiler-photo-image"><img src="{{fi-imgsrc}}" height="200px" border="0"></div><div class="jFiler-photo-actions"><ul class="list-inline"><li><a class="icon-jfi-trash jFiler-item-trash-action">' + I18n.t('js.filer.trash') + '</a></li></ul></div></div></li>',
        itemAppendToEnd: true,
      },
      uploadFile: {
        url: $form.attr('action'),
        data: that.extraData,
        type: 'POST',
        enctype: 'multipart/form-data',
        synchron: true,
        beforeSend: function(filerItem){ CDLV.pubSub.trigger('filer:upload:before', filerItem) },
        success: function(data, filerItem){ CDLV.pubSub.trigger('filer:upload:success', data, filerItem) },
        error: function(filerItem){ CDLV.pubSub.trigger('filer:upload:error', filerItem) }
      },
      captions: that.localizeCaptions(),
      afterShow: function(){ CDLV.pubSub.trigger('filer:add'); return true },
      onRemove: function(filerItem){ CDLV.pubSub.trigger('filer:remove', filerItem); return true }
    }).prop("jFiler")
    $('.jFiler-items-list').slick({
      infinite: false,
      speed: 300,
      slidesToShow: 3,
      slidesToScroll: 3,
      centerMode: false,
      responsive: [
        {
          breakpoint: 1024,
          settings: {
            arrows: false,
            dots: false
          }
        },
      ]
    })
  },

  localizeCaptions: function(){
    return {
      button: I18n.t('js.filer.button'),
      feedback: I18n.t('js.filer.feedback'),
      feedback2: I18n.t('js.filer.feedback2'),
      drop: I18n.t('js.filer.drop'),
      removeConfirmation: I18n.t('js.filer.removeConfirmation'),
      errors: {
        filesLimit: I18n.t('js.filer.errors.filesLimit'),
        filesType: I18n.t('js.filer.errors.filesType'),
        filesSize: I18n.t('js.filer.errors.filesSize'),
        filesSizeAll: I18n.t('js.filer.errors.filesSizeAll'),
        folderUpload: I18n.t('js.filer.errors.folderUpload')
      }
    }
  },

  addFile: function(){
    this.displayMessage(false)
  },

  alert: function(text){
    this.displayMessage(text)
  },

  removeFile: function(filerItem){
    var that = this
    var photoId = filerItem.data('photo-id')

    if( _.isEmpty(photoId) ) return true

    var url = '/admin/ajax/photos/'+photoId
    this.displayMessage(false)
     $.ajax({
      url: url,
      data: that.extraData,
      type: 'delete',
      cache: false,
    }).done(function(data){
      $('.jFiler-items-list').slick('reinit')
      return true
    }).fail(function(xhr){
      return false
    })
  },

  displayMessage: function(display){
    if( _.isString(display) ){
      var message = '<div class="messages">' +
          '<div class="message secondary">'+display+'</div>' +
          '<div>'
      this.$el.prepend(message)
    } else if( _.isBoolean(display) && !display ){
      this.$el.find('.messages').remove()
    }
  },

  beforeUpload: function(filerItem){
    filerItem.find('.jFiler-item-assets').hide()
  },

  uploadError: function(filerItem){
    filerItem.find('.jFiler-item-assets').show()
    filerItem.find('.jFiler-jProgressBar .bar').addClass('red')
    filerItem.find('.jFiler-item-inner').append('<div class="jFiler-item-upload-status pull-left"><span class="error">'+I18n.t('js.filer.upload.error')+'</span></div>')
  },

  uploadSuccess: function(data, filerItem){
    filerItem.find('.jFiler-item-assets').show()
    filerItem.find('.jFiler-jProgressBar .bar').addClass('green')
    filerItem.data('attachment-id', data.response.id)
  }
})
