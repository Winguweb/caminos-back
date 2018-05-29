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
    var $form = this.$el.find('form')
    var $input = $form.find('#'+options.fileInputId)

    this.owner = options.owner || {}
    this.loadingImage = options.loadingImage

    this.on({
      'filer:add': this.addFile,
      'filer:alert': this.alert,
      'filer:upload:before': this.beforeUpload,
      'filer:upload:error': this.uploadError,
      'filer:upload:success': this.uploadSuccess,
      'filer:select': this.selectFile,
      'filer:remove': this.removeFile
    })

    this.filerInput = $input.filer({
      limit: 50,
      maxSize: 100,
      fileMaxSize: 10,
      extensions: ['jpg', 'jpeg', 'png'],
      changeInput: true,
      showThumbs: true,
      addMore: true,
      appendTo: '.photos-uploads',
      dialogs: {
        alert: function(text) {
          return that.trigger('filer:alert', text)
        }
      },
      files: options.images || [],
      templates: {
        item: '<li class="jFiler-item jFiler-photo" data-photo-id="{{fi-phid}}"><div class="jFiler-photo-inner"><div class="jFiler-photo-image"><span class="jFiler-item-status">{{fi-progressBar}}</span><img src="{{fi-imgsrc}}" height="200px" border="0"></div><div class="jFiler-photo-actions"><ul class="list-inline"><li><a class="icon-jfi-trash jFiler-item-trash-action">' + I18n.t('js.filer.trash') + '</a></li></ul></div></div></li>',
        itemAppend: '<li class="jFiler-item jFiler-photo" data-photo-id="{{fi-phid}}"><div class="jFiler-photo-inner"><div class="jFiler-photo-image"><img src="{{fi-imgsrc}}" height="200px" border="0"></div><div class="jFiler-photo-actions"><ul class="list-inline"><li><a class="icon-jfi-trash jFiler-item-trash-action">' + I18n.t('js.filer.trash') + '</a></li></ul></div></div></li>',
        itemAppendToEnd: true,
        progressBar: '<div class="bar"></div>',
      },
      uploadFile: {
        url: $form.attr('action'),
        type: 'POST',
        enctype: 'multipart/form-data',
        synchron: false,
        beforeSend: function(filerItem){ that.trigger('filer:upload:before', filerItem) },
        success: function(data, filerItem){ that.trigger('filer:upload:success', data, filerItem) },
        error: function(filerItem){ that.trigger('filer:upload:error', filerItem) }
      },
      captions: that.localizeCaptions(),
      onSelect: function(data, filerItem){ that.trigger('filer:select', data, filerItem); return true },
      beforeShow: function(){ that.trigger('filer:add'); return true },
      onRemove: function(filerItem){ that.trigger('filer:remove', filerItem); return true }
    }).prop("jFiler")
    this.slickInit()
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

  selectFile: function(file, filerItem){
    var reader = new FileReader()
    reader.onloadend = function () {
      filerItem.find('img')[0].setAttribute('src', reader.result)
    }

    reader.readAsDataURL(file)
    this.displayMessage(false)
  },

  alert: function(text){
    this.displayMessage(text)
  },

  removeFile: function(filerItem){
    var that = this
    var photoId = filerItem.data('photo-id')

    if( _.isEmpty(photoId) ) return true

    var url = '/admin/ajax/'+this.owner.pluralizeName+'/'+this.owner.id+'/photos/'+photoId

    filerItem.fadeOut(300, function() {
      $(this).remove()
      that.$el.find('.jFiler-items-list').slick('reinit')
    })
    this.displayMessage(false)
     $.ajax({
      url: url,
      type: 'delete',
      cache: false,
    }).done(function(data){

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
    this.slickInit()
    filerItem.appendTo($('.slick-track'))
    this.$el.find('.jFiler-items-list').slick('reinit')
    filerItem.addClass('uploading-item')
    this.$el.find('.jFiler-items-list').slick('slickGoTo', $('.slick-track .slick-slide').length);
  },

  uploadError: function(filerItem){
    filerItem.find('.jFiler-jProgressBar .bar').addClass('red')
    filerItem.find('.jFiler-item-inner').append('<div class="jFiler-item-upload-status pull-left"><span class="error">'+I18n.t('js.filer.upload.error')+'</span></div>')
  },

  uploadSuccess: function(data, filerItem){
    filerItem.data('photo-id', data.response.id)
    filerItem.removeClass('uploading-item')
    filerItem.find('.jFiler-jProgressBar').fadeOut()
    CDLV.pubSub.trigger('photo:add', data)
  },
  slickInit: function() {
    if (this.slickInitialized()) return
    this.$el.find('.jFiler-items-list').slick({
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
  slickInitialized: function() {
    return $('.slick-track').length > 0
  }
})
