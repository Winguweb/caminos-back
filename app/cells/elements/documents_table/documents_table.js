CDLV.Components['documents/table'] = Backbone.View.extend({
  events: {
    'click .remove-document': 'removeDocumentAction',
  },

  initialize: function(options){
    _.bindAll(
      this,
      'addDocument',
      'removeDocument'
    )

    var $template = this.$el.find('#document-template')
    var $emptyTemplate = this.$el.find('#no-documents-template')
    this.template = _.template($template.html())
    this.emptyTemplate = _.template($emptyTemplate.html())

    $template.remove()
    $emptyTemplate.remove()

    this.$tableBody = this.$el.find('.documents-table-body')
    this.documentsIds = options.documentsIds || []

    CDLV.pubSub.on({
      'document:add:done': this.addDocument,
      'document:remove:done': this.removeDocument
    })
  },

  removeDocumentAction: function(evt) {
    var $el = $(evt.target)
    var documentId = $el.data('document-id')
    var documentType = $el.data('document-type')
    $el.closest('tr').addClass('removing')

    CDLV.pubSub.trigger('document:remove:'+documentType, documentId)
    return false
  },

  addDocument: function(data){
    this.$tableBody.append( this.template(data.response) )
    this.documentsIds.push(data.response.id)
    this.noDocumentsVisibility()
  },

  removeDocument: function(documentId){
    var index = this.documentsIds.indexOf(documentId)

    this.$tableBody.find('#'+documentId).remove()

    if( index != -1 ) {
      this.documentsIds.splice(index, 1)
    }
    this.noDocumentsVisibility()
  },

  noDocumentsVisibility: function(){
    if( this.documentsIds.length == 0 ){
      this.$tableBody.append( this.emptyTemplate() )
    } else {
      this.$tableBody.find('.no-documents').remove()
    }
  }
})
