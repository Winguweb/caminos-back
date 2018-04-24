class Photo < ApplicationRecord
  mount_uploader :image, PhotoUploader

  belongs_to :owner, polymorphic: true
  belongs_to :uploader, class_name: 'User', foreign_key: 'uploader_id'
end
