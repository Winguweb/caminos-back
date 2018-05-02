class Meeting < ApplicationRecord
  belongs_to :neighborhood
  has_and_belongs_to_many :works
  has_many :documents, as: :holder

  validates_presence_of :date,
    :objectives

  default_scope { order(date: :asc) }

  def next
    Meeting.where(neighborhood_id: neighborhood_id).where("date > ?", date).order(date: 'asc').first
  end

  def prev
    Meeting.where(neighborhood_id: neighborhood_id).where("date < ?", date).order(date: 'desc').first
  end
end



