class Work < ApplicationRecord
  belongs_to :neighborhood
  validates_presence_of :name, :address
  has_and_belongs_to_many :meetings
end