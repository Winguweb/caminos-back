class Work < ApplicationRecord
  belongs_to :neighborhood
  validates_presence_of :name, :address, :start_date, :end_date,:status,:description,:budget,:manager,:execution_plan

  validate :valid_dates

  def valid_dates
    if (start_date && end_date) && (end_date < start_date)
      errors.add(:invalid_dates, "invalid_dates please check now")
    end
  end
  
end