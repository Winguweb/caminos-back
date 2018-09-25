class Elements::NeighborhoodCardCell < Cell::ViewModel
  include LayoutHelper
  include AgreementsUtils

  private

  def neighborhood
    @neighborhood ||= model
  end

  def average
    agreement_data = parsed_agreement_data(neighborhood.agreement)
    agreement_data.blank? ? 0 : agreements_average(agreement_data)
  end

end
