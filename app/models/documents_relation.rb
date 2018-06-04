class DocumentsRelation < ApplicationRecord
  belongs_to :document
  belongs_to :relatable, polymorphic: true
  belongs_to :responsible, class_name: 'User', foreign_key: :responsible_id
end
