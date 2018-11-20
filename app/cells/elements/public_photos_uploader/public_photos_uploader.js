CDLV.Components['public_photos/uploader'] = Backbone.View.extend({
  events: {
  'click .form_photo_cta': 'addFieldsPhoto',
  'change .form_photo_invisible_input': 'addImageText'
  },
  initialize: function(options){
    this.$addPhotoInput = this.$el.find('.form_photo_invisible_input')
    this.$addPhotoCta = this.$el.find('.form_photo_cta')
    this.photoCount = 0
  },

  addFieldsPhoto: function(){
    if(this.photoCount < 5){
      this.$addPhotoInput.click()
    }
    this.photoCount ++
  },
  addImageText: function(){
    this.$el.append('<p class="form_photo_item">'+this.$addPhotoInput[0].files[0].name+'</p>')
  }
})
