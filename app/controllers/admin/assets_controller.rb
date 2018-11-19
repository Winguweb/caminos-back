module Admin
  class AssetsController < BaseController
    include CurrentAndEnsureDependencyLoader
    include UsersHelper

    before_action :restrict_if_responsible, only: [:destroy]
    helper_method :current_neighborhood

    def edit
      ensure_neighborhood; return if performed?

      @categories = Asset.categories
      @verifications = Asset.verification_status
      load_asset
    end

    def index
      ensure_neighborhood; return if performed?

      @assets = current_neighborhood.assets
    end

    def show
      ensure_neighborhood; return if performed?

      load_asset
    end

    def update
      ensure_neighborhood; return if performed?

      load_asset
      service = UpdateAsset.call(@asset, asset_params)

      if service.success?
        redirect_to admin_neighborhood_asset_path
      else
        flash.now[:error] =  load_errors(service.errors)
        @categories = Asset.categories
        @verification_status = Asset.verification_status
        load_asset
        render action: :edit
      end
    end

    def destroy
      ensure_neighborhood; return if performed?

      load_asset

      if @asset.destroy
        redirect_to admin_neighborhood_assets_path(current_neighborhood)
      else
        redirect_back(fallback_location: admin_dashboard_path)
      end
    end

    private

    def load_errors(errors)
      messages  = []
      errors.each do |error|
        messages << t('admin.assets.errors', field: t("assets.#{error}"))
      end
      return messages
    end

    def load_asset
      @asset = current_neighborhood.assets.friendly.find(params[:id])
    end

    def asset_params
      params.require(:asset).permit(
        :description,
        :geometry,
        :geo_geometry,
        :lookup_address,
        :name,
        :verification,
        :category_list
      )
    end

  end
end
