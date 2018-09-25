module AgreementsHelper
  include AgreementsUtils

  def average(neighborhood = @neighborhood)
    agreement_data = parsed_agreement_data(neighborhood.agreement)
    agreement_data.blank? ? 0 : agreements_average(agreement_data)
  end
end
