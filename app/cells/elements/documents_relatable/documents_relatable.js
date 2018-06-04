CDLV.Components['documents/relatable'] = Backbone.View.extend({
  events: {
    'click .relate-button .button': 'relateDocument'
  },

  initialize: function(options){
    _.bindAll(
      this,
      'displayComponent'
    )

    var $button = this.$el.find('#'+options.buttonId)

    this.owner = options.owner || {}
    this.$form = this.$el.find('form')

    var $select = this.$form.find('select').selectize({
      allowEmptyOption: false,
      closeAfterSelect: true,
      create: false
    })
    this.selectizeDocuments = $select[0].selectize
    this.selectizeDocuments.clear(true)
    this.relateButton = this.$el.find('.relate-button .button')

    $button.on('click', this.displayComponent)
  },

  displayComponent: function(){
    this.$el.show()
  },

  relateDocument: function(){
    var that = this
    var url = this.$form.attr('action')

    $.ajax({
      type: 'POST',
      url: url,
      data: this.$form.formParams(),
      dataType: 'json'
    }).done(function(data){
      CDLV.pubSub.trigger('document:add', data)
    }).fail(function(xhr){
      console.log("ERROR:")
      console.log(xhr)
    })

  }

})
