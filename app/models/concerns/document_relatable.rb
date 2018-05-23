module DocumentRelatable
  extend ActiveSupport::Concern

  included do
    has_many :documents_relations, as: :relatable, dependent: :destroy
    has_many :documents, through: :documents_relations
  end
end
