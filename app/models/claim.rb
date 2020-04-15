class Claim < ApplicationRecord
  extend FriendlyId
  friendly_id :slug_candidates, use: %i[slugged finders history]
  enum verification: [:verification_pending, :verification_rejected, :verification_approved]

  belongs_to :neighborhood
  belongs_to :work, optional: true
  has_many :public_photos, as: :owner

  acts_as_taggable_on :categories

  validates_presence_of(
    :category_list,
    :description,
    :geo_geometry,
    :geometry,
    :name,
  )

  validate :valid_categories

  CATEGORIES = %w[
    health
    energy
    sewer
    trash
    water
    home
    nutrition
    violence
    internet
    income
  ].freeze

  private_constant :CATEGORIES

  def self.categories
    CATEGORIES
  end

  def self.icon(category)
    ActionController::Base.helpers.image_url("icons/category-claim.svg")
  end

  def valid_categories
    errors.add(:category_list, "errors") unless category_list.present?
  end

  def category
    tags_on(:categories).first
  end

  def category_icon
    'icons/category-claim.svg'
  end

  def category_icon_shadow
    'icons/category-claim-shadow.svg'
  end

  def slug_candidates
    [
        :name,
        [:name, :description],
        [:name, :description, :id]
    ]
  end
 end
