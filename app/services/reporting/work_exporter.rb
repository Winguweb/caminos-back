module Reporting
  class WorkExporter < Exporter
    include AgreementsHelper
    HEADER = ["neighborhood","name","description","status","start_date","estimated_end_date","lookup_address","geo_geometry","geometry","budget","manager","execution_plan","created_at","updated_at"].freeze

    def initialize(options = {})
      @works = options[:data]
    end

    def filename
      "works_#{Time.now.strftime('%Y-%m-%d')}"
    end

    def sheetname
      "works"
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
      @works.each do |work|
        yield row_data(work)
      end
    end

    def row_data(work)
      [
        
        print_neighborhood(work.neighborhood_id),
        work.name,
        work.description,
        work.status,
        work.start_date,
        work.estimated_end_date,
        work.lookup_address,
        work.geo_geometry,
        work.geometry,
        work.budget,
        work.manager,
        work.execution_plan,
        work.created_at,
        work.updated_at,
        
      ]
    end

    def print_neighborhood(id)
      Neighborhood.find(id).name
    end
  end
end
