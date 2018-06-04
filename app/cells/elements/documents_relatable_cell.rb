class Elements::DocumentsRelatableCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def owner_related_documents_ids
    @owner_related_documents_ids ||= owner.documents.pluck(:id)
  end

  def url
    ::Rails.application.routes.url_helpers.send(:"admin_ajax_#{owner_class_name}_documents_relations_path", owner_id)
  end

  def drive_documents_options
    roots = Drive.roots.order(:name)

    options_groups = roots.each_with_object({}) do |root, _object|
      _object[root.name] = root.descendants.only_files.map do |drive_document|
        next if owner_related_documents_ids.include?(drive_document.id)

        [ drive_document.path.from_depth(1).pluck(:name).join(" / "), drive_document.id ]
      end.compact.sort
    end

    options_groups.to_a
  end

  def button_id
    @button_id ||= (options[:button_id] || 'relate_document_button')
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
