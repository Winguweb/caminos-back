class Elements::PhotosUploaderCell < Cell::ViewModel

  private

  def url
    admin_ajax_photos_upload_path
  end

  def images
    return [] if model.blank?

    @images ||= model.map do |photo|
      {
        opts: { phid: photo.id },
        name: photo.image.file.original_filename,
        type: photo.image.file.content_type,
        file: photo.image.url
      }
    end.to_json
  end

  def file_input_id
    @file_input_id ||= options[:file_input_id]
  end

  def owner
    @owner ||= options[:owner]
  end
end
