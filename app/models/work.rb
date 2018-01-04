class Work < ApplicationRecord
  belongs_to :neighborhood

  validates_presence_of :name,
    :description,
    :status,
    :start_date,
    :estimated_end_date,
    :lookup_coordinates,
    :budget,
    :manager,
    :execution_plan

  validate :valid_dates

  def valid_dates
    if start_date && estimated_end_date && (estimated_end_date < start_date)
      errors.add(:invalid_dates, "invalid_dates please check now")
    end
  end

end
