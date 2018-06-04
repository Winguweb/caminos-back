module Admin::Ajax
  class DocumentsRelationsController < BaseController
    include CurrentAndEnsureDependencyLoader

    def create
      if document
        document_relation = DocumentsRelation.new(
          document: document,
          relatable: current_owner,
          responsible: current_user
        )

        if document_relation.valid?
          if document_relation.save
            render json: {
              response: {
                id: document.id,
                icon_type: document.icon_type,
                url: document.url,
                name: document.name,
                description: document.description,
                created_at: I18n.l(document.created_at, format: :basic)
              }
            }, status: 201
          else
            render json: {
              errors: document_relation.errors
            }, status: 500
          end
        else
          render json: {
            errors: document_relation.errors
          }, status: 422
        end
      else
        render json: {
          errors: [ I18n.t('admin.ajax.documents_relations.errors.document_not_found') ]
        }, status: 404
      end
    end

    def destroy
      if document_relation = current_owner.documents_relations.find_by(id: params[:id])
        if document_relation.destroy
          render json: {
            response: {
              success: true
            }
          }, status: 200
        else
          render json: {
            errors: [ I18n.t('admin.ajax.documents_relations.errors.destroy') ]
          }, status: 500
        end
      else
        render json: {
          errors: [ I18n.t('admin.ajax.documents_relations.errors.destroy') ]
        }, status: 422
      end
    end

    private

    def current_owner
      return @current_owner if defined?(@current_owner)

      @current_owner = current_work || current_neighborhood || current_meeting
    end

    def document
      return @document if defined?(@document)

      neighborhood = current_neighborhood ? current_neighborhood : current_owner.neighborhood

      @document = Document.where(neighborhood: neighborhood, id: document_relation_params[:document_id]).last
    end

    def document_relation_params
      params.require(:documents_relation).permit( :document_id )
    end

  end
end
