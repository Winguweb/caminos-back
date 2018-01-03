class Neighborhood < ApplicationRecord

  validates_presence_of :name, :description
 
  has_many :users, as: :entity
end
