CDLV.Components['photos'] = Backbone.View.extend({
  initialize: function(options){
    var container = document.getElementById("photos");
    var btn = this.$el.find('#btnAdd')
    btn.on('click', function(evt) {
      addFieldsPhoto(options.owner)
    })
  }
})

function addFieldsPhoto(owner){
  var container = document.getElementById("photos");
  var limit = 5;
  if(container.childElementCount/2 < limit ){

    container.appendChild(document.createTextNode("Foto"));
    var input = document.createElement("input");
    input.type = "file";
    input.name = owner + "[photos][]picture" ;
    container.appendChild(input);
    container.appendChild(document.createElement("br"));
    
  }
  else{
    console.log(container.childElementCount/2)
  }
}
  