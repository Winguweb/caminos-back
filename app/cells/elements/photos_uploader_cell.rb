class Elements::PhotosUploaderCell < Cell::ViewModel

  private

  def url
    admin_ajax_photos_upload_path
  end

  def images
    return [] if model.blank?

    @images ||= model.map do |photo|
      {
        opts: { phid: photo.id, imgsrc: photo.image.thumb.url },
        name: photo.original_filename,
        type: photo.content_type
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
