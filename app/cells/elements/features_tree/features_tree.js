CDLV.Components['features/tree'] = Backbone.View.extend({
  events: {
  'click .open-list-button': 'toggleList',
  'click .filter-action': 'categorySelected',
  },
  initialize: function(options) {
    _.bindAll(
        this,
        'toggleList',
        'changeFilterClass',
        'changeFilterStatus',
        'categorySelected'
    )
    this.options = this.translate(options)
    this.neighborhoodSlug = this.options.neighborhood_slug
    this.render(this.options)
    CDLV.pubSub.on({
      'filter-toggle:changed:class': this.changeFilterClass,
    })

    CDLV.pubSub.on({
      'filter-toggle:changed:status': this.changeFilterStatus,
    })
  },
  render: function(data) {
      console.error()
      this.$el.html( this.feature_template({icons: data.category_icons, features: data.features, categories: data.categories, neighborhood_slug: this.neighborhoodSlug, filter_name: this.filter_name}));
  },
  translate: function(data) {
    for (var c in data.categories) {
      var category = data.categories[c]
      for (var w in data.features[category]) {
        if (data.features[category][w].status == null) continue;
        data.features[category][w].status = {
          code: data.features[category][w].status,
          name: I18n.t('js.status.' + data.features[category][w].status)
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
  changeFilterClass: function(filter_name) {
    var _self = this
    this.filter_name = filter_name
    var featureType = {Asset: 'assets', Claim: 'claims'}[filter_name]
    axios.get('/api/neighborhoods/' + this.neighborhoodSlug + '/' + featureType)
    .then(function (response) {
      _self.options.features = response.data[featureType]
      console.log(_self.options.features)
      _self.options.categories = response.data.categories
      _self.options = _self.translate(_self.options)
      _self.render(_self.options)
    })
    .catch(function (response) {
      console.log("error")
    })
  },
  changeFilterStatus: function(filter_name) {
    var _self = this
    this.filter_name = filter_name
    axios.get('/api/neighborhoods/' + this.neighborhoodSlug + '/works/status/' + filter_name)
    .then(function (response) {
      _self.options.features = response.data.features
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
  feature_template: _.template('<% if(categories.length) { %><ul><% _.each(categories, function(category) { %><li><div><button class="open-list-button" <%= features[category.code].length == 0 ? "disabled" : "" %>>+</button><div class="filter-action" data-category-name="<%= category.code %>"><i class="category-<%= category.code %>"><img src="<%= icons[category.code] %>" alt="" /></i><span><%= category.name %></span><span><%= features[category.code].length %></span></div></div><ul><% _.each(features[category.code], function(feature) { %><li><a href="/barrios/<%= neighborhood_slug  %>/obras/<%= feature.slug %>"><div><i class="category-<%= category.code %>"></i><span><%= feature.name %></span></div><% if(feature.status) { %><div><span class="status-<%= feature.status.code %>"><%= feature.status.name %></span></div><% } %></a></li><% }); %></ul></li><% }); %></ul><% } else { %><span>'+ I18n.t('js.filter.no_results') + ' <%= I18n.t("js.status."+filter_name) %></span><% } %>')
})

