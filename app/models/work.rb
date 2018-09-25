class Work < ApplicationRecord
  include DocumentRelatable

  extend FriendlyId
  friendly_id :name, use: %i(slugged finders history)

  belongs_to :neighborhood
  has_and_belongs_to_many :meetings
  has_many :photos, as: :owner

  acts_as_taggable_on :categories

  validates_presence_of :name,
    :description,
    :status,
    :manager,
    :name,
    :category_list,
    :lookup_address,
    :geo_geometry

  validate :valid_categories

  # validate :valid_dates

  # CATEGORIES =['Servicios Públicos','Equipamiento Estatal','Vivienda','Espacios Públicos'].freeze
  CATEGORIES =['water', 'trash', 'public', 'health', 'energy', 'sewer', 'infrastructure', 'home'].freeze
  STATUS =['in_process','done', 'pending','expired','proyected'].freeze

  def self.status
    STATUS
  end

  def self.categories
    CATEGORIES
  end

  def valid_categories
    if category_list.nil? || category_list.empty?
      errors.add(:category_list, "errors")
    end
  end

  def valid_dates
    if start_date && estimated_end_date && (estimated_end_date < start_date)
      errors.add(:invalid_dates, "invalid_dates please check now")
    end
  end

  def category
    self.tags_on(:categories).first
  end

  # TO-DO: Remove this after tags implementation
  def category_icon
    category.blank? ? 'icons/category-editable.svg' : "icons/category-#{category}.svg"
  end

end
