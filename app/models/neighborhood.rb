class Neighborhood < ApplicationRecord
  
  has_many :works, dependent: :destroy
  has_many :ambassadors, class_name: 'Responsible'
  has_many :users, through: :ambassadors

  has_many :meetings, through: :works

  validates_presence_of :name, :description, :ambassadors
  validate :is_ambassador?

  def is_ambassador?
    
    self.ambassadors.each do |ambassador|
      return errors.add(:role, "no ambassador ") if !ambassador.user.roles.include?(:ambassador)
    end
    
  end

end
