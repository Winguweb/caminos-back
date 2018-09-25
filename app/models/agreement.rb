class Agreement < ApplicationRecord
  belongs_to :neighborhood
  validates :neighborhood, uniqueness: true

  def self.indicators
    @indicators || read_indicators
  end

  private_class_method def self.read_indicators
    YAML.load_file("#{Rails.root}/config/agreements.yml").with_indifferent_access
  end

end
