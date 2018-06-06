class Elements::DocumentsUploaderCell < Cell::ViewModel

  private

  def url
    ::Rails.application.routes.url_helpers.send(:"admin_ajax_#{owner_class_name}_documents_upload_path", owner_id)
  end

  def file_input_id
    @file_input_id ||= (options[:file_input_id] || 'document_file_input')
  end

  def owner_class_name
    @owner_class_name ||= owner.class.name.underscore
  end

  def owner_pluralize_name
    @owner_pluralize_name ||= owner.class.name.pluralize.underscore
  end

  def owner_id
    @owner_id ||= owner.id
  end

  def owner
    @owner ||= options[:owner]
  end
end
