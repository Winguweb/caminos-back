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
    
    if !self.works.empty? 

      if self.works.map{|work|  work.neighborhood_id }.min != self.works.map{|work| work.neighborhood_id }.max 
        errors.add(:neighborhood_work, "The works doesn't have the same neighborhood")
      else
        self.works.each do |work|  
          if work.neighborhood_id != self.neighborhood_id
            return errors.add(:neighborhood_work, "The neighborhood works are diferent of this neighborhood")
          end
        end
      end

    end

  end

end


    