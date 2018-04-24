CDLV.Components['docs'] = Backbone.View.extend({
  initialize: function(options){
    var container = document.getElementById("documents");
    var btn = this.$el.find('#addDoc')
     
    btn.on('click', function(evt) {
      addFields(options.owner)
    })
  }
})

function addFields(owner){
  var container = document.getElementById("documents");
  var limit = 5;
  if(container.childElementCount/3 < limit ){

    container.appendChild(document.createTextNode("Link del documento "));
    var input = document.createElement("input");
    input.type = "text";
    input.name = owner + "[documents][]link" ;
    container.appendChild(input);

    container.appendChild(document.createTextNode("Nombre del documento "));
    var input = document.createElement("input");
    input.type = "text";
    input.name = owner+"[documents][]name" ;
    container.appendChild(input);

    container.appendChild(document.createTextNode("Descripcion del description "));
    var input = document.createElement("input");
    input.type = "text";
    input.name = owner+"[documents][]description" ;
    container.appendChild(input);
  }
  else{
    console.log(container.childElementCount/3)
  }
}
  