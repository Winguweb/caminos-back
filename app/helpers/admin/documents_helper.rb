module Admin
  module DocumentsHelper

    def get_neighborhood(owner)
      owner.is_a?(Neighborhood) ? owner : owner.neighborhood
    end

    def related_documents_buttons(with_gdrive_documents, file_input_id, relate_button_id)
      [
        ({ title: I18n.t('admin.helpers.documents.relate_document'), for: relate_button_id } if with_gdrive_documents),
        { title: I18n.t('admin.helpers.documents.upload_document'), for: file_input_id }
      ].compact
    end

  end
end
