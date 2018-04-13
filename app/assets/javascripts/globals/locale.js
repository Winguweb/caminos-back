;(function(){
  // Set current locale and the default one.
  I18n.defaultLocale = 'es'
  I18n.fallbacks = true
  var locale = $('meta[name="locale"]').attr('content')

  if( _.isString(locale) && locale.length ) I18n.locale = locale

  // jQuery.timeago translation based on locale
  if( window.moment && locale == 'es' ) moment.lang('es')
})()
