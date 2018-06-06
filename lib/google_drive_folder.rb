require 'document'
require 'google/apis/drive_v3'

class GoogleDriveFolder

  FOLDER_MIME_TYPE = 'application/vnd.google-apps.folder'.freeze
  private_constant :FOLDER_MIME_TYPE

  def self.folder_mime_type
    FOLDER_MIME_TYPE
  end

  def initialize(neighborhood)
    @service = Google::Apis::DriveV3::DriveService.new
    @service.key = DRIVE_API_KEY

    @neighborhood = neighborhood
    @root_folder_id = @neighborhood.gdrive_folder_id

    @root_folder = begin
      @service.get_file(@root_folder_id) if @root_folder_id
    rescue Google::Apis::ClientError => e
      nil
    end

    self
  end

  def valid?
    @root_folder_id.present? && @root_folder.present?
  end

  def has_documents?
    return false unless @root_folder_id.present?

    Drive.where(neighborhood: @neighborhood).with_neighborhood_gdrive_folder_id(@root_folder_id).size > 0
  end

  def name
    return I18n.t('admin.google_drive.folder.invalid') unless valid?

    @root_folder.name
  end

  def root_folder_content(create_documents: false)
    return {} unless valid?

    folder_content(@root_folder_id, create_documents: create_documents)
  end

  private

  def folder_content(folder_id, create_documents: false,  parent_folder: nil)
    folder_tree = {}

    response = @service.list_files(
      q: "'#{folder_id}' in parents",
      fields: 'files(mimeType, id, name, version, description, size, lastModifyingUser, createdTime, modifiedTime, fileExtension, webViewLink, thumbnailLink)'
    )

    response.files.each do |file|
      folder_tree[file.id] = { file: file }

      save_document_if_not_exist(file, parent_folder: parent_folder) if create_documents

      if file.mime_type == FOLDER_MIME_TYPE
        folder_tree[file.id][:childs] = folder_content(file.id, create_documents: create_documents, parent_folder: file)
      end
    end

    folder_tree
  end

  def save_document_if_not_exist(file, parent_folder: nil)
    return if Drive.where(neighborhood: @neighborhood).with_drive_id(file.id).last

    if parent_folder
      parent_document = Drive.where(neighborhood: @neighborhood).with_drive_id(parent_folder.id).last
    end

    drive_params = {
      neighborhood: @neighborhood,
      name: file.name,
      file_type: file.mime_type,
      file_size: file.size,
      drive_id: file.id,
      neighborhood_gdrive_folder_id: @root_folder_id,
      drive_file_hash: file.to_h,
      created_at: file.created_time,
      updated_at: file.modified_time
    }.tap do |_hash|
      _hash[:parent] = parent_document if (parent_folder && parent_document)
    end

    Drive.create!(drive_params)
  end
end

# barrio = Neighborhood.find('e5e30949-c86a-4640-a69e-b6e3ddebe760');barrio.name
# gdrive = barrio.google_drive_folder;
# gdrive.root_folder_content(create_documents: true)
