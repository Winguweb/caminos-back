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
    neighborhood = Neighborhood.new(@allowed_params)
    neighborhood.agreement = Agreement.new
    return neighborhood if neighborhood.save

    errors.add_multiple_errors(neighborhood.errors.messages) && nil
  end

end