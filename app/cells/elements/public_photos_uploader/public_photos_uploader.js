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
    console.log(this.photoCount)
  },
  addImageText: function(){
    this.$el.append('<p class="form_photo_item">'+this.$addPhotoInput[0].files[0].name+'</p>')
  }
})



// function addFieldsPhoto(owner){
//   var container = document.getElementById("photos");
//   var limit = 5;
//   if(container.childElementCount/2 < limit ){

//     container.appendChild(document.createTextNode("Foto"));
//     var input = document.createElement("input");
//     input.type = "file";
//     input.name = owner + "[photos][]image" ;
//     container.appendChild(input);
//     container.appendChild(document.createElement("br"));
    
//   }
//   else{
//     console.log(container.childElementCount/2)
//   }
// }
  
