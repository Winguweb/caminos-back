class Neighborhood < ApplicationRecord
  has_many :meetings
  has_many :users, as: :entity
  has_many :photos, as: :owner
  has_many :works
  has_many :documents, as: :holder
  has_one :agreement
  validates_presence_of :name, :description, :geo_polygon, :polygon
end
