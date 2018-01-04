class Neighborhood < ApplicationRecord
  has_many :meetings
  has_many :users, as: :entity
  has_many :works

  validates_presence_of :name, :description
end
