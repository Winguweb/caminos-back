class Meeting < ApplicationRecord
  belongs_to :neighborhood
  has_and_belongs_to_many :works

  validates_presence_of :date,
    :objectives,
    :organizer,
    :participants

  validate :works_verification 
  private 
  	def works_verification
  		return true if self.works.empty?

  		self.works.each do |work|
  			#validar que todos las obras sean del mismo barrio
  		end
  	end
end
