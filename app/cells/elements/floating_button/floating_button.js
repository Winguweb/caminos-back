CDLV.Components['elements/floating_button'] = Backbone.View.extend({
  initialize: function(options) {
    _.bindAll(
      this,
      'citizenParticipationAdd'
    )
    this.neighborhoodSlug = options.neighborhoodId
    CDLV.pubSub.on({'citizen-participation:add': this.citizenParticipationAdd})
    this.citizenParticipationAdd()
  },

  citizenParticipationAdd: function(filter_name){
    this.$el.find('.floating-btn-text #citizen-participation-add').remove()
    this.$el.find('.floating-btn-text').append(this.citizenParticipationUrl(filter_name))
  },

  citizenParticipationUrl: function(filter_name){
    if(!filter_name) return '<a id="citizen-participation-add" href="/barrios/' + this.neighborhoodSlug + '/assets/new">mapear</a>'

    return '<a id="citizen-participation-add" href="/barrios/' + this.neighborhoodSlug + '/' + filter_name + '/new">' + this.translateText(filter_name) + '</a>'
  },

  translateText: function(filter_name){
    if(filter_name === 'claims') return 'Reportar'

    return 'Mapear'
  }
})
