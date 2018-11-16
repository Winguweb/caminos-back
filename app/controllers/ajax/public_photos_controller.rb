module Ajax
  class PublicPhotosController < BaseController
    include CurrentAndEnsureDependencyLoader

    def destroy
      if photo = current_owner.photos.find_by(id: params[:id])
        if photo.destroy
          render json: {
            response: {
              success: true
            }
          }, status: 200
        else
          render json: {
            errors: [ I18n.t('admin.ajax.photos.errors.destroy') ]
          }, status: 500
        end
      else
        render json: {
          errors: [ I18n.t('admin.ajax.photos.errors.destroy') ]
        }, status: 422
      end
    end

    def upload
      photo = current_owner.public_photos.new( extended_params )

      if photo.valid?
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
          errors: photo.errors
        }, status: 422
      end
    end

    private

    def current_owner
      current_claim
    end

    def photo_params
      params.require(:public_photo).permit( image:[] )
    end

    def extended_params
      cloned_allowed_params = photo_params.deep_dup
      cloned_allowed_params.tap do |_hash|
        _hash[:image] = _hash[:image][0]
      end
    end

  end
end
