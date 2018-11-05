class Claim < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i[slugged finders history]

  belongs_to :neighborhood
  belongs_to :work, optional: true

  acts_as_taggable_on :categories

  validates_presence_of(
    :category_list,
    :description,
    :geo_geometry,
    :geometry,
    :lookup_address,
    :name,
  )

  validate :valid_categories
   
  CATEGORIES = %w[
    building_infrastructure
    health_ambulance
    light_electricity
    sewerage
    streets_parks
    trash
    water
  ].freeze

  private_constant :CATEGORIES

  def self.categories
    CATEGORIES
  end
  
  def valid_categories
    errors.add(:category_list, "errors") unless category_list.present?
  end
  
  def category
    tags_on(:categories).first
  end
  
  def category_icon
    category.blank? ? 'icons/category-editable.svg' : "icons/category-#{category}.svg"
  end
 end