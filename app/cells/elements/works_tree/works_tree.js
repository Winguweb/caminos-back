CDLV.Components['works/tree'] = Backbone.View.extend({
  events: {
  'click .open-list-button': 'toggleList',
  'click .filter-action': 'categorySelected',
  },
  initialize: function(options) {
    _.bindAll(
        this,
        'toggleList',
        'changeFilter',
        'categorySelected'
    )
    this.options = this.translate(options)
    this.neighborhoodSlug = this.options.neighborhood_slug
    this.render(this.options)
    CDLV.pubSub.on({
      'filter-toggle:changed:status': this.changeFilter,
    })
  },
  render: function(data) {
      this.$el.html( this.work_template({works:data.works, categories: data.categories, neighborhood_slug: this.neighborhoodSlug, filter_name: this.filter_name}));
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
    axios.get('/api/neighborhoods/' + this.neighborhoodSlug + '/works/status/' + filter_name)
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
  categorySelected: function(ev) {
    filterItem = $(ev.currentTarget)
    $filterItems = this.$el.find('.filter-action').parent().parent().removeClass('active')
    filterItem.parent().parent().addClass('active')
    categoryName = $(filterItem).data('category-name')
    CDLV.pubSub.trigger('map-show:filter:category', categoryName)
  },
  work_template: _.template('<% if(categories.length) { %><ul><% _.each(categories, function(category) { %><li><div><button class="open-list-button" <%= works[category.code].length == 0 ? "disabled" : "" %>>+</button><div class="filter-action" data-category-name="<%= category.code %>"><i class="category-<%= category.code %>"></i><span><%= category.name %></span><span><%= works[category.code].length %></span></div></div><ul><% _.each(works[category.code], function(work) { %><li><a href="/barrios/<%= neighborhood_slug  %>/obras/<%= work.slug %>"><div><i class="category-<%= category.code %>"></i><span><%= work.name %></span></div><div><span class="status-<%= work.status.code %>"><%= work.status.name %></span></div></a></li><% }); %></ul></li><% }); %></ul><% } else { %><span>'+ I18n.t('js.filter.no_results') + ' <%= I18n.t("js.status."+filter_name) %></span><% } %>')
})

