class UpdateNeighborhood
  prepend Service::Base

  def initialize(neighborhood,allowed_params)
    @allowed_params = allowed_params
    @neighborhood = neighborhood
  end

  def call
    update_neighborhood
  end

  private

  def update_neighborhood
    
    @neighborhood.update(@allowed_params)
    return @neighborhood if @neighborhood.save
    errors.add_multiple_errors(@neighborhood.errors.messages) && nil
  end

end


