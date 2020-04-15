class Elements::ClaimsTableCell < Cell::ViewModel
  include ::Cell::Translation
  private

  def claims
    @claims ||= model
  end

  def filters
   @filters ||= options[:filters]
  end

  def neighborhood
    @neighborhood ||= options[:neighborhood]
  end

  def claim_url(id)
    return admin_neighborhood_claim_path(id) if options[:admin]
    neighborhood_claim_path(id)
  end

end