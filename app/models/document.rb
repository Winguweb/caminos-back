class Document < ApplicationRecord
  belongs_to :holder, polymorphic: true

  validates_presence_of :name,
    :description,
    :attachment_type,
    :attachment_source,
    :filetype,
    :holder_type,
    :holder_id
end
