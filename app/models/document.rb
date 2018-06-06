class Document < ApplicationRecord
  autoload :Drive, '.'
  autoload :Uploaded, '.'

  attribute :data, :jsonb, default: {}

  scope :drive, -> { where('type = ?', 'Drive') }
  scope :uploaded, -> { where('type = ?', 'Uploaded') }

  belongs_to :neighborhood
  has_many :documents_relations, dependent: :destroy

  has_many :meetings, through: :documents_relations, source: :relatable, source_type: 'Meeting'
  has_many :neighborhoods, through: :documents_relations, source: :relatable, source_type: 'Neighborhood'
  has_many :works, through: :documents_relations, source: :relatable, source_type: 'Work'

  def icon_type
    file_type.try(:parameterize)
  end
end

class Drive < Document
  has_ancestry cache_depth: true

  scope :only_files, -> { where('file_type != ?', GoogleDriveFolder.folder_mime_type) }
  scope :with_drive_id, -> (id) { where('data @> ?', { drive_id: id }.to_json) }
  scope :with_neighborhood_gdrive_folder_id, -> (id) { where('data @> ?', { neighborhood_gdrive_folder_id: id }.to_json) }

  DATA_FIELDS = %w[
    drive_id
    neighborhood_gdrive_folder_id
    drive_file_hash
  ].freeze
  private_constant :DATA_FIELDS

  DATA_FIELDS.each do |data_field_name|
    attribute :"#{data_field_name}"

    define_method :"#{data_field_name}" do
      data && data[data_field_name]
    end

    define_method :"#{data_field_name}=" do |new_value|
      self.data = data || {}
      self.data[data_field_name] = new_value
    end
  end

  def view_link
    drive_file_hash[:web_view_link]
  end
  alias :url :view_link

  def thumbnail_link
    drive_file_hash[:thumbnail_link]
  end
end

class Uploaded < Document
  mount_uploader :attachment, AttachmentUploader

  delegate :url, to: :attachment
end
