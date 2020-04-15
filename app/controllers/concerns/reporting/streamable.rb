# Internal: In order to be able to return data as CSV as a Stream
module Reporting
  module Streamable
    include ActiveSupport::Concern

    def stream_xlsx()
      buffer = StringIO.new
      xlsx = Xlsxtream::Workbook.new(buffer)

      xlsx.write_worksheet 'Reportes' do |sheet|
        sheet << get_char_headers
        claims = current_neighborhood.claims

        claims.each do |claim|
          sheet << [
            claim.name,
            claim.description,
            claim.category.name,
            claim.date
          ]
        end
      end

      xlsx.close
      buffer.rewind

      set_xlsx_file_headers("reportes")
      set_streaming_headers

      self.response_body = buffer.read
      
    end

    private

    def set_xlsx_file_headers(filename)
      file_name = "#{filename}.xlsx"
      headers['Content-Type'] = 'application/vnd.ms-excel; charset=utf-8; header=present'
      headers['Content-Disposition'] = "attachment; filename=\"#{file_name}\""
    end
  
    def set_streaming_headers
      headers['Cache-Control'] = 'no-cache'
      headers['X-Accel-Buffering'] = 'no'
      headers.delete('Content-Length')
    end

    def get_char_headers
      return [
        "Nombre", 
        "Descripcion",
        "categoria",
        "fecha"
      ]
    end
  end
end
