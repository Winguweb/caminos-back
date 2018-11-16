class PublicPhoto < ApplicationRecord
  mount_uploader :image, PhotoUploader

  belongs_to :owner, polymorphic: true
 
end
