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
    
    if documents_params.present? 
      documents_params.each do |document|
        service_document = SaveDrive.call(document[:link],document[:name])
        if (service_document.success?)
          document =  @neighborhood.documents.new(name:document[:name], description:document[:description], attachment_source:service_document.result. alternate_link)
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

  def documents_params
    documents = []
    @allowed_params[:documents].each do |doc|
      documents.push(doc) if !doc[:link].blank?
    end
    documents
  end
end