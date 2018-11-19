class Asset < ApplicationRecord

  extend FriendlyId
  friendly_id :name, use: %i[slugged finders history]
  enum verification: [:verification_pending, :verification_rejected, :verification_approved]

  belongs_to :neighborhood

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
    community_center
    cult
    education
    food_kitchen
    health
    infrastructure
    public_organization
  ].freeze

  private_constant :CATEGORIES

  def self.categories
    CATEGORIES
  end

  def self.verification_status
    verifications.keys
  end

  def valid_categories
    errors.add(:category_list, "errors") unless category_list.present?
  end

  def category
    tags_on(:categories).first
  end

  def category_icon
    category.blank? ? 'icons/category-asset-editable.svg' : "icons/category-asset-#{category}.svg"
  end

  def category_icon_shadow
    category.blank? ? 'icons/category-asset-editable.svg' : "icons/category-asset-#{category}-shadow.svg"
  end

end
