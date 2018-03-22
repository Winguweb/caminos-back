class Photo < ApplicationRecord
	belongs_to :owner, polymorphic: true
	mount_uploader :picture, PhotoUploader
end
