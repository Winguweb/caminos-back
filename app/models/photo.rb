class Photo < ApplicationRecord
	belongs_to :owner, polymorphic: true
end
