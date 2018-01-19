class Meeting < ApplicationRecord
  belongs_to :neighborhood
  has_and_belongs_to_many :works

  validates_presence_of :date,
    :objectives,
    :organizer,
    :participants
end



