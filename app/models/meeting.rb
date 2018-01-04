class Meeting < ApplicationRecord
  belongs_to :neighborhood

  validates_presence_of :date,
    :lookup_coordinates,
    :objectives,
    :organizer,
    :participants
end
