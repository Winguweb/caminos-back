class Work < ApplicationRecord
  belongs_to :neighborhood
  validates_presence_of :name, :address
end