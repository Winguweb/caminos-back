class CreateNeighborhood
  prepend Service::Base

  def initialize(allowed_params)
    @allowed_params = allowed_params
  end

  def call
    create_neighborhood
  end

  private

  def create_neighborhood
    @neighborhood = Neighborhood.new(neighborhood_params)
    @neighborhood.agreement = Agreement.new

    if !document_param.nil? 
      document_param.each do |document|
        service_document = SaveDrive.call(document[:link])
        if (service_document != nil)
          document =  @neighborhood.documents.new(name:document[:name], description:document[:description], attachment_source:"https://www.googleapis.com/drive/v2/files/#{service_document.result.id}")
          document.holder = @neighborhood
        end
      end
      
      return @neighborhood if @neighborhood.save
      errors.add_multiple_errors(@neighborhood.errors.messages) && nil
      
    else
      return @neighborhood if @neighborhood.save
      errors.add_multiple_errors(@neighborhood.errors.messages) && nil
    end


  end

  def neighborhood_params
    {
      name: @allowed_params[:name],
      description: @allowed_params[:description],
      lookup_coordinates: @allowed_params[:lookup_coordinates],
      lookup_address: @allowed_params[:lookup_address],
      geo_polygon: @allowed_params[:geo_polygon],
      polygon: @allowed_params[:polygon],
    }
  end

  def document_param
    @allowed_params[:documents]
  end
end