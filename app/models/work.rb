class Work < ApplicationRecord
  belongs_to :neighborhood
  has_many :events, class_name: 'Calendar'
  has_many :meetings, through: :events

  validates_presence_of :name, :address, :start_date, :end_date,:status,:description,:budget,:manager,:execution_plan

  validate :valid_dates

  def valid_dates
    if (start_date && end_date) && (end_date < start_date)
      errors.add(:invalid_dates, "invalid_dates please check now")
    end
  end
  
end