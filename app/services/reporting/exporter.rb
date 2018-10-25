require 'csv'

module Reporting
  class Exporter

    def filename
      raise NotImplementedError.new(self, __method__)
    end

    def sheetname
      nil
    end

    def csv_stream
      raise NotImplementedError.new(self, __method__)
    end

    def data_stream
      raise NotImplementedError.new(self, __method__)
    end

    private

    def csv_header
      raise NotImplementedError.new(self, __method__)
    end

    def csv_row
      raise NotImplementedError.new(self, __method__)
    end

    def yielder
      raise NotImplementedError.new(self, __method__)
    end

    def row_data
      raise NotImplementedError.new(self, __method__)
    end

  end

  class NotImplementedError < StandardError
    attr_reader :object

    def initialize(object, method_name)
      @object = object
      class_name = object.class == Class ? object : object.class
      super("Missing implementation for the Method ##{method_name} under #{class_name.to_s} Class.")
    end
  end
end
