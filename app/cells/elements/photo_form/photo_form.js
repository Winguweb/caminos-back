CDLV.Components['photos'] = Backbone.View.extend({
  initialize: function(options){
    _.bindAll(
        this,
        'addFile',
        'alert'
    )

    var that = this;
    var $form = this.$el.find('form')
    var $input = $form.find('.file-input')

    CDLV.pubSub.on({
      'filer:add': this.addFile,
      'filer:alert': this.alert,
      'filer:upload:before': this.beforeUpload,
      'filer:upload:error': this.uploadError,
      'filer:upload:success': this.uploadSuccess,
      'filer:remove': this.removeFile
    })

    this.filerInput = $input.filer({
      limit: options.limit || 1,
      maxSize: 20,
      fileMaxSize: 10,
      extensions: ['jpg', 'jpeg', 'png'],
      changeInput: true,
      showThumbs: true,
      addMore: true,
      appendTo: '#photos_preview',
      dialogs: {
        alert: function(text) {
          return CDLV.pubSub.trigger('filer:alert', text)
        }
      },
      files: options.files || [],
      templates: {
        item: '<li class="jFiler-item" data-attachment-id=""><div class="jFiler-item-container"><div class="jFiler-item-inner"><div class="jFiler-item-icon pull-left">{{fi-icon}}</div><div class="jFiler-item-info pull-left"><div class="jFiler-item-title" title="{{fi-name}}">{{fi-name | limitTo:30}}</div><div class="jFiler-item-others"><span>Tamaño: {{fi-size2}}</span><span>Tipo: {{fi-extension}}</span><span class="jFiler-item-status">{{fi-progressBar}}</span></div><div class="jFiler-item-assets"><ul class="list-inline"><li><a class="icon-jfi-trash jFiler-item-trash-action">' + I18n.t('js.filer.trash') + '</a></li></ul></div></div></div></div></li>',
        itemAppend: '<li class="jFiler-item" data-attachment-id="{{fi-aid}}"><div class="jFiler-item-container"><div class="jFiler-item-inner"><div class="jFiler-item-icon pull-left">{{fi-icon}}</div><div class="jFiler-item-info pull-left"><div class="jFiler-item-title">{{fi-name | limitTo:35}}</div><div class="jFiler-item-others"><span>Tamaño: {{fi-size2}}</span><span>Tipo: {{fi-extension}}</span><span class="jFiler-item-status"></span></div><div class="jFiler-item-assets"></div></div></div></div></li>',
        itemAppendToEnd: true,
      },
      captions: that.localizeCaptions(),
      afterShow: function(){ CDLV.pubSub.trigger('filer:add'); return true },
      onRemove: function(filerItem){ CDLV.pubSub.trigger('filer:remove', filerItem); return true }
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
})
