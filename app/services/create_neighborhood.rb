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
    @ambassadors_params.each do |ambassador|
      @neighborhood.ambassadors.build(user: User.find(ambassador))
    end
    
    return @neighborhood if @neighborhood.save
    errors.add_multiple_errors(@neighborhood.errors.messages) && nil
  
  end

  def neighborhood_params
    @ambassadors_params ||= @allowed_params.delete('ambassadors')
    @allowed_params
  end
end
