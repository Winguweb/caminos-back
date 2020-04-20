# Internal: In order to be able to return data as CSV as a Stream
module Reporting
  module Streamable
    include ActiveSupport::Concern

    def stream_claims_by_neighborhood()
      buffer = StringIO.new
      xlsx = Xlsxtream::Workbook.new(buffer)

      xlsx.write_worksheet 'Problematicas' do |sheet|
        sheet << get_char_headers
        claims = current_neighborhood.claims.select{ |claim| claim.verification != 'verification_rejected'}

        claims.each do |claim|
          sheet << [
            claim.name,
            claim.description,
            t("categories.#{claim.category}"),
            claim.lookup_address,
            claim.date
          ]
        end
      end

      xlsx.close
      buffer.rewind

      set_xlsx_file_headers("problematicas_" + current_neighborhood.name)
      set_streaming_headers

      self.response_body = buffer.read
      
    end

    def stream_all_claims
      buffer = StringIO.new
      xlsx = Xlsxtream::Workbook.new(buffer)

      xlsx.write_worksheet 'Problematicas' do |sheet|
        sheet << get_all_claims_headers
        claims = Claim.all.select{ |claim| claim.verification != 'verification_rejected'}
        
        claims.each do |claim|
          sheet << [
            claim.name,
            claim.description,
            t("categories.#{claim.category}"),
            claim.lookup_address,
            claim.neighborhood.name,
            claim.date
          ]
        end
      end

      xlsx.close
      buffer.rewind

      set_xlsx_file_headers("problematicas")
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
        "Categoria",
        "Direccion",
        "Fecha"
      ]
    end

    def get_all_claims_headers
      return [
        "Nombre",
        "Descripcion",
        "Categoria",
        "Direccion",
        "Barrio",
        "Fecha"
      ]
    end
  end
end
