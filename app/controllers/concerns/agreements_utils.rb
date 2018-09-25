module AgreementsUtils
  extend ActiveSupport::Concern

  protected

  def agreement_not_present?(agreement)
    agreement.nil? || agreement.data.nil?
  end

  def parsed_agreement_data(agreement)
    return if agreement_not_present?(agreement)
    JSON.parse(agreement.data).with_indifferent_access
  end

  def agreements_average(agreements_data)
    total_agreement_values(agreements_data) / agreements_length(agreements_data)
  end

  def total_agreement_values(agreements_data)
    agreements_data.sum {|d| d[1]["score"].to_i}
  end

  def agreements_length(agreements_data)
    agreements_data.size
  end
end
