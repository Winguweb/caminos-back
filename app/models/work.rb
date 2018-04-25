class Work < ApplicationRecord
  belongs_to :neighborhood
  has_and_belongs_to_many :meetings
  has_many :documents, as: :holder
  has_many :photos, as: :owner

  acts_as_taggable_on :categories

  validates_presence_of :name,
    :description,
    :status,
    :start_date,
    :estimated_end_date,
    :budget,
    :manager,
    :name,
    :execution_plan,
    :category_list

  validate :valid_dates

  # CATEGORIES =['Servicios Públicos','Equipamiento Estatal','Vivienda','Espacios Públicos'].freeze
  CATEGORIES =['water', 'trash', 'public', 'health', 'energy', 'sewer', 'infrastructure'].freeze
  STATUS =['in_process','done', 'pending','expired','proyected'].freeze

  def self.status
    STATUS
  end

  def self.categories
    CATEGORIES
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
