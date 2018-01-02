class Meeting < ApplicationRecord
  has_many :public_works, class_name: 'Calendar'
  has_many :works, through: :public_works

  validates_presence_of :public_works
end
