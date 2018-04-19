class Meeting < ApplicationRecord
  include DocumentRelatable

  belongs_to :neighborhood
  has_and_belongs_to_many :works

  validates_presence_of :date, :objectives
end



