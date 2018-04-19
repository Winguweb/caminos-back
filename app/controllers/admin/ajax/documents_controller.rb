module Admin::Ajax
  class DocumentsController < BaseController
    include CurrentAndEnsureDependencyLoader

    def delete
      binding.pry
      if document = current_owner.documents.find_by(id: params[:id])
        if false #photo.destroy
          render json: {
            response: {
              success: true
            }
          }, status: 200
        else
          render json: {
            errors: [ I18n.t('admin.ajax.documents.errors.delete') ]
          }, status: 500
        end
      else
        render json: {
          errors: [ I18n.t('admin.ajax.documents.errors.delete') ]
        }, status: 422
      end
    end

    def upload
      binding.pry
      # document = current_owner.documents.new( extended_params )

      if false #photo.valid?
        if photo.save
          render json: {
            response: {
              id: photo.id,
              url: photo.image.thumb.url
            }
          }, status: 201
        else
          render json: {
            errors: photo.errors
          }, status: 500
        end
      else
        render json: {
          errors: '' #photo.errors
        }, status: 422
      end
    end

    private

    def current_owner
      current_work || current_neighborhood || current_meeting
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
