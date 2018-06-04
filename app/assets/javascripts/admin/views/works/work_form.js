CDLV.Components['work_form'] = Backbone.View.extend({
  initialize: function(options) {
    _.bindAll(
      this,
      'categoryChanged'
    )

    this.categoryByParents = {
      public_services: {keys: ["water", "trash", "public", "energy", "sewer"], title: "Servicios Públicos: "},
      state_equipment: {keys: ["health"], title: "Equipamiento Estatal: "},
      public_spaces: {keys: ["infrastructure"], title: "Espacios Públicos: "},
      home: {keys: ["home"], title: "Vivienda: "},
      empty: {keys: [""], title: I18n.t('js.admin.works.select_a_category')},
    }

    this.$select = this.$el.find('#work_category_list')
    this.$options = this.$el.find('#work_category_list option')
    this.$label = this.$el.find('.category-parent')

    this.$select.on('change', this.categoryChanged)

    for (var index = 0; index < this.$options.length; index++) {
     if (this.$options[index].value != "" ){
      var parentIndex = this.getParentFromCategory(this.$options[index].value)
      this.$options[index].value = [this.$options[index].value, parentIndex].join(',')
     }

    }

    if(this.$select.val() != "" ){
      this.changeParentValue(this.$select.val())
    }
  },
  categoryChanged: function(el) {
    if(el.target.value != "" ){
       this.changeParentValue(el.target.value)
    }

  },
  changeParentValue: function(value) {
    var parentIndex = this.getParentFromCategory(value.split(',')[0])
    this.$label.text(this.categoryByParents[parentIndex].title)
  },
  getParentFromCategory: function(category) {
    for (var index in this.categoryByParents) {
      if (this.categoryByParents[index].keys.indexOf(category) > -1) {
        return index
      }
    }
  }

})
