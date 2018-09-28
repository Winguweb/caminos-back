class Agreement < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: %i[slugged finders scoped], scope: :neighborhood

  belongs_to :neighborhood
  validates :neighborhood, uniqueness: true

  def self.indicators
    @indicators || read_indicators
  end

  private

  private_class_method def self.read_indicators
    YAML.load_file("#{Rails.root}/config/agreements.yml").with_indifferent_access
  end

  def formatted_date
    return unless created_at.present?
    created_at.strftime('%d-%m-%Y')
  end

  def slug_candidates
    [
      :formatted_date
    ]
  end
end
