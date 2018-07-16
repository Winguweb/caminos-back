CDLV.Components['works/tree'] = Backbone.View.extend({
  events: {
  'click .open-list-button': 'toggleList',
  },
  initialize: function(options) {
    _.bindAll(
        this,
        'toggleList',
        'changeFilter'
    )
    this.options = this.translate(options)
    this.neighborhoodId = this.options.neighborhood_id
    this.render(this.options)
    CDLV.pubSub.on({
      'filter-toggle:changed': this.changeFilter,
    })
  },
  render: function(data) {
      this.$el.html( this.work_template({works:data.works, categories: data.categories, filter_name: this.filter_name}));
  },
  translate: function(data) {
    for (var c in data.categories) {
      var category = data.categories[c]
      for (var w in data.works[category]) {
        data.works[category][w].status = {
          code: data.works[category][w].status,
          name: I18n.t('js.status.' + data.works[category][w].status)
        }
      }
    }
    data.categories = data.categories.map(function(item) {
      return {code: item, name: I18n.t('js.categories.' + item)}
    })
    return data
  },
  toggleList: function(ev) {
    var target = $(ev.currentTarget)
    var list = target.parent().next('ul')
    target.toggleClass('opened')
    list.toggleClass('opened')
  },
  changeFilter: function(filter_name) {
    var _self = this
    this.filter_name = filter_name
    axios.get('/api/neighborhoods/' + this.neighborhoodId + '/works/status/' + filter_name)
    .then(function (response) {
      _self.options.works = response.data.works
      _self.options.categories = response.data.categories
      _self.options = _self.translate(_self.options)
      _self.render(_self.options)
    })
    .catch(function (response) {
      console.log("error")
    })

  },
  work_template: _.template('<% if(categories.length) { %><ul><% _.each(categories, function(category) { %><li><div><button class="open-list-button" <%= works[category.code].length == 0 ? "disabled" : "" %>>+</button><i class="category-<%= category.code %>"></i><span><%= category.name %></span><span><%= works[category.code].length %></span></div><ul><% _.each(works[category.code], function(work) { %><li><a href="#"><div><i class="category-<%= category.code %>"></i><span><%= work.name %></span></div><div><span class="status-<%= work.status.code %>"><%= work.status.name %></span></div></a></li><% }); %></ul></li><% }); %></ul><% } else { %><span>'+ I18n.t('js.filter.no_results') + ' <%= I18n.t("js.status."+filter_name) %></span><% } %>')
})

