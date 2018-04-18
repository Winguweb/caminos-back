/**
* Url Helper by @mjlescano
* Helper to manipulate or work with the url
*/
;(function(){
  var U = CDLV.Helpers.url = {
    stripParams: function(url){
      var index = url.indexOf('?')
      if( index > -1) return url.substr(0, index)
      return url
    },

    encode: function(val) {
      return encodeURIComponent( val ).replace(/[!'()*]/g, escape)
    },

    decode: function(param) {
      return decodeURIComponent( param )
    },

    toParams: function(object) {
      var that = this, s = []
      _.each(object, function(v, i) {
        if( v && (v+'').length ) {
          s.push(i +'='+ that.encode(v))
        }
      })
      s = s.join('&')
      return s.length ? '?' + s : ''
    },

    toObject: function(params) {
      var that = this;
      var r = /(?:[\&\?]?)([a-z0-9_\-]+)=([%0-9a-zA-Z_\-\.]+)/g;
      var object = {};
      if( params && typeof params === 'string' ) {
        params.replace(r , function(match, name, val) {
          val = that.decode( val )
          if( /,/.test(val) ) val = val.split(',')
          object[name] = val
        })
      }
      return object
    },

    getParamsObject: function() {
      return U.toObject(window.location.search)
    },

    isSameDomain: function(url) {
      $a = $('<a/>', { href: url })
      if( !location.origin ) {
        location.origin = location.protocol + "//" + location.hostname + (location.port ? ':' + location.port: '')
      }
      return location.origin === $a.prop('origin')
    }
  }
})()
