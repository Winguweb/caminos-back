module AgreementsParse
  extend ActiveSupport::Concern

  protected

  def agreement_not_present?(agreement)
    agreement.nil? || agreement.data.nil?
  end

  def parsed_agreement_data(agreement)
    return if agreement_not_present?(agreement)
    JSON.parse(agreement.data).with_indifferent_access
  end
end
