class Neighborhood < ApplicationRecord
  attribute :extras, :jsonb, default: {}

  include DocumentRelatable

  has_many :meetings
  has_many :users, as: :entity
  has_many :photos, as: :owner
  has_many :works
  has_one :agreement

  validates_presence_of :name, :description, :geo_geometry, :geometry

  EXTRAS = %w(
    gdrive_folder
  ).freeze
  private_constant :EXTRAS

  EXTRAS.each do |extra_name|
    attribute :"#{extra_name}"

    define_method :"#{extra_name}" do
      extras && extras[extra_name]
    end

    define_method :"#{extra_name}=" do |new_value|
      self.extras = extras || {}
      self.extras[extra_name] = new_value
    end
  end

  def gdrive_folder_id
    return nil unless gdrive_folder

    case gdrive_folder
    when /drive.google.com\/drive\/folders\/([\w\-]*)/
      "#{$1}"
    when /drive.google.com\/.*id=([\w\-]*)/
      "#{$1}"
    else
      nil
    end
  end

  def google_drive_folder
    @google_drive_folder ||= GoogleDriveFolder.new(self)
  end
end
