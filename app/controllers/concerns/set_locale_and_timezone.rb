module SetLocaleAndTimezone
  extend ActiveSupport::Concern

  protected

  # This method is intended to be used on a around_action
  # Examples
  #
  #   around_action :set_locale
  def set_locale
    I18n.locale = 'es-AR'
  end

  # This method is intended to be used on a around_action
  # as specify in https://robots.thoughtbot.com/its-about-time-zones or
  # here https://www.reinteractive.net/posts/168-dealing-with-timezones-effectively-in-rails
  # Examples
  #
  #   around_action :set_time_zone
  def set_time_zone(&block)
    Time.use_zone('Buenos Aires', &block)
  end
end
