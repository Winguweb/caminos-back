class Document < ApplicationRecord
  autoload :Drive, '.'
  autoload :Uploaded, '.'

  belongs_to :neighborhood
  has_many :documents_relations, dependent: :destroy

  has_many :meetings, through: :documents_relations, source: :relatable, source_type: 'Meeting'
  has_many :neighborhoods, through: :documents_relations, source: :relatable, source_type: 'Neighborhood'
  has_many :works, through: :documents_relations, source: :relatable, source_type: 'Work'

end

class Drive < Document; end

class Uploaded < Document; end
