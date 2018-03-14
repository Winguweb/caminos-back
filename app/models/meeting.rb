class Meeting < ApplicationRecord
  belongs_to :neighborhood
  has_and_belongs_to_many :works
  has_many :documents, as: :holder

  validates_presence_of :date,
    :objectives
end



