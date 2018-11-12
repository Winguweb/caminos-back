module Api
  class AssetsController < BaseController
    include CurrentAndEnsureDependencyLoader
    helper_method :current_neighborhood

    def index
      ensure_neighborhood; return if performed?
      unordered_assets = current_neighborhood.assets
      categories = Asset.categories
      neighborhood_slug = current_neighborhood.slug
      render :json => {assets: sort_by_category(unordered_assets, all: true), categories: categories, neighborhood_slug: neighborhood_slug}
    end

    private

    def sort_by_category(unordered_assets, all=false)
      assets = {}
      Asset.categories.each do |category|
        ordered_assets = unordered_assets.select do |asset|
          asset.category.name == category
        end
        assets[category] = ordered_assets if !ordered_assets.empty? || all
      end
      assets
    end
  end
end
