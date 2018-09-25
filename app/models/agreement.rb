class Agreement < ApplicationRecord
  belongs_to :neighborhood
  validates :neighborhood, uniqueness: true

  def self.indicators
    @indicators || @indicators = YAML.load_file("#{Rails.root.to_s}/config/agreements.yml").with_indifferent_access
  end
end
