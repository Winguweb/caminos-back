class Work < ApplicationRecord
  include DocumentRelatable

  extend FriendlyId
  friendly_id :name, use: %i[slugged finders history]

  belongs_to :neighborhood
  has_and_belongs_to_many :meetings
  has_many :photos, as: :owner

  acts_as_taggable_on :categories

  validates_presence_of(
    :category_list,
    :description,
    :geo_geometry,
    :lookup_address,
    :manager,
    :name,
    :status,
  )

  validate :valid_categories

  CATEGORIES = %w[
    energy
    health
    home
    infrastructure
    public
    sewer
    trash
    water
  ].freeze

  STATUS = %w[
    done
    expired
    in_process
    proyected
  ].freeze

  private_constant :CATEGORIES
  private_constant :STATUS

  def self.status
    STATUS
  end

  def self.categories
    CATEGORIES
  end

  def valid_categories
    errors.add(:category_list, "errors") unless category_list.present?
  end

  def valid_dates
    if start_date && estimated_end_date && (estimated_end_date < start_date)
      errors.add(:invalid_dates, "invalid_dates please check now")
    end
  end

  def category
    tags_on(:categories).first
  end

  def category_icon
    category.blank? ? 'icons/category-editable.svg' : "icons/category-#{category}.svg"
  end

end
