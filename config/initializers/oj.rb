Oj.optimize_rails

unless Rails.env.production?
  require 'tracer'

  # This is in order to check if Oj is being called by the serializers
  # to check you neew to wrap the call like this:
  #   Tracer.on
  #   // code to trace
  #   Tracer.off
  Tracer.display_c_call = true
end
