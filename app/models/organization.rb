class Organization < ApplicationRecord
  has_many :users, as: :entity

  validates_presence_of :name, :description
end
