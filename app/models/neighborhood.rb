class Neighborhood < ApplicationRecord
  has_many :works, dependent: :destroy
  has_many :ambassadors, class_name: 'Responsible'
  has_many :users, through: :responsibles
  validates_presence_of :name, :description, :ambassadors
  # validate :is_ambassador?

  # def is_ambassador?
  # 	errors.add(:role, "no ambassador ") if !User.first.roles.include?(:ambassador)
  # end

end
