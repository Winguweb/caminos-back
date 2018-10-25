module Reporting
  class NeighborhoodExporter < Exporter
    include AgreementsHelper
    HEADER = ["name","description","geo_geometry","geometry","created_at","updated_at","urbanization","urbanization_score","urbanization_data"].freeze

    def initialize(options = {})
      @neighborhoods = options[:data]
    end

    def filename
      "neighborhoods_#{Time.now.strftime('%Y-%m-%d')}"
    end

    def sheetname
      "neighborhoods"
    end

    def csv_stream
      Enumerator.new do |result|
        result << csv_header

        yielder do |row|
          result << csv_row(row)
        end
      end
    end

    def data_stream
      Enumerator.new do |result|
        result << header

        yielder do |row|
          result << row
        end
      end
    end

 
    private

    def header
      @header ||= HEADER
    end


    def csv_header
      CSV::Row.new(header, header, true).to_s
    end

    def csv_row(values)
      CSV::Row.new(header, values).to_s
    end

    def yielder
      @neighborhoods.each do |neighborhood|
        yield row_data(neighborhood)
      end
    end

    def row_data(neighborhood)
      [
        neighborhood.name,
        neighborhood.description,
        neighborhood.geo_geometry,
        neighborhood.geometry,
        neighborhood.created_at,
        neighborhood.updated_at,
        neighborhood.urbanization,
        average(neighborhood),
        print_agreement(neighborhood.id)
      ]
    end

    def print_agreement(id)
      agreement = Agreement.where(neighborhood_id: id).last
      return "sin acuerdo " if agreement.nil?
      agreement.data
    end
  end
end
