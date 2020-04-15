class UpdateClaim
  prepend Service::Base

  def initialize(claim, allowed_params)
    @allowed_params = allowed_params
    @claim = claim
  end

  def call
    update_claim
  end

  private

  def update_claim
    return @claim if @claim.update(@allowed_params)
    errors.add_multiple_errors(@claim.errors.messages) && nil
  end

end

