require 'document'

module Admin::Ajax
  class DocumentsController < BaseController
    include CurrentAndEnsureDependencyLoader

    def destroy
      if document = current_owner.documents.find_by(id: params[:id])
        if document.destroy
          render json: {
            response: {
              success: true
            }
          }, status: 200
        else
          render json: {
            errors: [ I18n.t('admin.ajax.documents.errors.destroy') ]
          }, status: 500
        end
      else
        render json: {
          errors: [ I18n.t('admin.ajax.documents.errors.destroy') ]
        }, status: 422
      end
    end

    def upload
      document = Uploaded.new( extended_params )
      document.neighborhood = current_neighborhood ? current_neighborhood : current_owner.neighborhood

      if document.valid?
        if document.save

          DocumentsRelation.create(document: document, relatable: current_owner, responsible: current_user)

          render json: {
            response: {
              id: document.id,
              icon_type: document.icon_type,
              url: document.url,
              name: document.name,
              description: document.description,
              created_at: I18n.l(document.created_at, format: :basic),
              type: document.type.downcase
            }
          }, status: 201
        else
          render json: {
            errors: document.errors
          }, status: 500
        end
      else
        render json: {
          errors: document.errors
        }, status: 422
      end
    end

    private

    def current_owner
      return @current_owner if defined?(@current_owner)

      @current_owner = current_work || current_neighborhood || current_meeting
    end

    def document_params
      params.require(:document).permit( attachment:[] )
    end

    def extended_params
      cloned_allowed_params = document_params.deep_dup
      cloned_allowed_params.tap do |_hash|
        _hash[:attachment] = _hash[:attachment][0]
      end
    end

  end
end
