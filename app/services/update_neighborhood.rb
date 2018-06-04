class UpdateNeighborhood
  prepend Service::Base

  def initialize(neighborhood, allowed_params)
    @neighborhood = neighborhood
    @allowed_params = allowed_params
  end

  def call
    update_neighborhood
  end

  private

  def update_neighborhood
    @neighborhood.assign_attributes( @allowed_params )

    return @neighborhood if !@neighborhood.changed? || @neighborhood.save

    errors.add_multiple_errors(@neighborhood.errors.messages) && nil
  end

end


