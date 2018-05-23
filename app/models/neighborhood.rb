class Neighborhood < ApplicationRecord
  include DocumentRelatable

  has_many :meetings
  has_many :users, as: :entity
  has_many :photos, as: :owner
  has_many :works
  has_one :agreement

  validates_presence_of :name, :description, :geo_geometry, :geometry

  # TO-DO: Remove this after tags implementation
  def category
    ["water", "trash", "public", "health", "energy", "sewer", "infrastructure"][rand(7)]
  end
end
