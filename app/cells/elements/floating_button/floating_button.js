CDLV.Components['elements/floating_button'] = Backbone.View.extend({
  initialize: function(options) {
    _.bindAll(
      this,
      'citizenParticipationAdd'
    )

    CDLV.pubSub.on({
      'citizen-participation:add': this.citizenParticipationAdd,
    })
  },

  citizenParticipationAdd: function(filter_name){
    console.log(filter_name)
  }
})