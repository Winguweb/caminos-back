# Internal: In order to be able to return data as CSV as a Stream
module Reporting
  module Streamable
    include ActiveSupport::Concern

    def stream_csv(exporter, *args)
      raise MistypeError.new(self, Exporter, __method__) unless exporter.ancestors.include? Exporter
      
      exporter = exporter.new(*args)

      set_file_headers(exporter.filename)
      set_streaming_headers

      response.status = 200

      self.response_body = exporter.csv_stream
    end

    private
    
    def set_file_headers(filename)
      file_name = "#{filename}.csv"
      headers['Content-Type'] = 'text/csv; charset=utf-8; header=present'
      headers['Content-Disposition'] = "attachment; filename=\"#{file_name}\""
      headers["X-Accel-Buffering"] = "no"
    end

    def set_streaming_headers
      headers['Cache-Control'] = 'no-cache'
      headers['X-Accel-Buffering'] = 'no'
      headers.delete('Content-Length')
    end
  end

  class MistypeError < StandardError
    attr_reader :object

    def initialize(object, expected_class, method_name)
      @object = object
      super("The Method ##{method_name} called in #{object.class.name} was expecting an exporter kind of: #{expected_class.to_s} Class.")
    end
  end
end
