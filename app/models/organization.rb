class Organization < ApplicationRecord
  
  validates_presence_of :name, :topics
  has_many :users, as: :entity

end
