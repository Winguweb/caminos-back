class Responsible < ApplicationRecord
  belongs_to :user
  belongs_to :neighborhood
   validates_presence_of :user, :neighborhood
end
