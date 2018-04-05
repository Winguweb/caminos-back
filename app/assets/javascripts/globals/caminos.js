;(function(){
  var root = this

  root.$window = $(window)
  root.$document = $(document)
  root.$body = $('body')
  root.$html = $('html')

  var CDLV = root.CDLV = root.CDLV || {}
  _.extend(CDLV, {
    Components: {},
    Helpers: {},
    mobile: root.$html.hasClass('mobile'),
    pubSub: Backbone.Events,
    Views: {},
    Routers: {}
  })

  // Send token on every ajax call that is not a GET
  CDLV.CSRFtoken = $('meta[name="csrf-token"]').attr('content')
  if( typeof CDLV.CSRFtoken !== 'string' || !CDLV.CSRFtoken.length ) {
    CDLV.CSRFtoken = null
  } else {
    $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
      if( CDLV.Helpers.url.isSameDomain(options.url) ) {
        jqXHR.setRequestHeader('X-CSRF-Token', CDLV.CSRFtoken)
      }

      jqXHR.promise().fail(function(xhr){
        var url = xhr.responseJSON.url
        if( xhr.status === 302 && !_.isEmpty(url)){
          window.location.href = url
        }
      })
    })
  }
})();
