class Calendar < ApplicationRecord
  belongs_to :work
  belongs_to :meeting
  validates_presence_of :work, :meeting
end
