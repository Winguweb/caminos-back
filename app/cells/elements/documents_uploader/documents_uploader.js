CDLV.Components['documents/uploader'] = Backbone.View.extend({
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

    this.on({
      'filer:add': this.addFile,
      'filer:alert': this.alert,
      'filer:upload:before': this.beforeUpload,
      'filer:upload:error': this.uploadError,
      'filer:upload:success': this.uploadSuccess,
      'filer:remove': this.removeFile
    })

    this.filerInput = $input.filer({
      limit: 50,
      maxSize: 200,
      fileMaxSize: 10,
      extensions: ['jpg', 'jpeg', 'png', 'doc', 'docx', 'xls', 'xlsx', 'pdf'],
      changeInput: true,
      showThumbs: true,
      addMore: true,
      appendTo: '.documents-uploads',
      dialogs: {
        alert: function(text) {
          return that.trigger('filer:alert', text)
        }
      },
      files: [],
      templates: {
        item: '<li class="jFiler-item" data-document-id=""><div class="jFiler-item-container"><div class="jFiler-item-inner"><div class="jFiler-item-icon pull-left">{{fi-icon}}</div><div class="jFiler-item-info pull-left"><div class="jFiler-item-title" title="{{fi-name}}">{{fi-name | limitTo:30}}</div><div class="jFiler-item-others"><span>Tamaño: {{fi-size2}}</span><span>Tipo: {{fi-extension}}</span><span class="jFiler-item-status">{{fi-progressBar}}</span></div><div class="jFiler-item-assets"><ul class="list-inline"><li><a class="icon-jfi-trash jFiler-item-trash-action">' + I18n.t('js.filer.trash') + '</a></li></ul></div></div></div></div></li>',
        itemAppend: '<li class="jFiler-item-dummy"></li>',
        itemAppendToEnd: true,
      },
      uploadFile: {
        url: $form.attr('action'),
        type: 'POST',
        enctype: 'multipart/form-data',
        synchron: true,
        beforeSend: function(filerItem){ that.trigger('filer:upload:before', filerItem) },
        success: function(data, filerItem){ that.trigger('filer:upload:success', data, filerItem) },
        error: function(filerItem){ that.trigger('filer:upload:error', filerItem) }
      },
      captions: that.localizeCaptions(),
      afterShow: function(){ that.trigger('filer:add'); return true },
      onRemove: function(filerItem){ that.trigger('filer:remove', filerItem); return true }
    }).prop("jFiler")
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
    var documentId = filerItem.data('document-id')

    if( _.isEmpty(documentId) ) return true

    var url = '/admin/ajax/'+this.owner.pluralizeName+'/'+this.owner.id+'/documents/'+documentId
    this.displayMessage(false)
     $.ajax({
      url: url,
      type: 'delete',
      cache: false,
    }).done(function(data){
      CDLV.pubSub.trigger('document:remove', documentId)
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
    filerItem.data('document-id', data.response.id)
    filerItem.find('.jFiler-item-assets').show()
    filerItem.find('.jFiler-jProgressBar .bar').addClass('green')
    CDLV.pubSub.trigger('document:add', data)
  }
})
