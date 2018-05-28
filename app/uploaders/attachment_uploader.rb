class AttachmentUploader < CarrierWave::Uploader::Base
  storage :aws

  before :cache, :save_original_filename

  process :save_content_type_and_size_in_model

  def save_original_filename(file)
    model.name ||= file.original_filename if file.respond_to?(:original_filename)
  end

  def save_content_type_and_size_in_model
    model.file_type = file.content_type if file.content_type
    model.file_size = file.size
  end

  def store_dir
    "neighborhoods/#{model.neighborhood_id}/attachments/#{model.class.base_class.to_s.underscore.pluralize}/#{model.id}"
  end

  def extension_white_list
    %w[jpg jpeg png doc docx xls xlsx pdf]
  end
end
