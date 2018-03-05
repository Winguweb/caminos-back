class Work < ApplicationRecord
  belongs_to :neighborhood
  has_and_belongs_to_many :meetings

  # TO-DO: Remove this after tags implementation
  attribute :category
  attribute :category_icon

  validates_presence_of :name,
    :description,
    :status,
    :start_date,
    :estimated_end_date,
    :budget,
    :manager,
    :name,
    :execution_plan

  validate :valid_dates

  def valid_dates
    if start_date && estimated_end_date && (estimated_end_date < start_date)
      errors.add(:invalid_dates, "invalid_dates please check now")
    end
  end

  #TO-DO: replace this when feature is implemented
  # def category
  #   'sdsdf'
  # end

end
