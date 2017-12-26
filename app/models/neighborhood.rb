class Neighborhood < ApplicationRecord
	has_many :works, dependent: :destroy
end
