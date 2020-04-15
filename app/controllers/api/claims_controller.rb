module Api
  class ClaimsController < BaseController
    include CurrentAndEnsureDependencyLoader
    include Reporting::Streamable
    helper_method :current_neighborhood

    def index
      ensure_neighborhood; return if performed?
      unordered_claims = current_neighborhood.claims
      categories = Claim.categories
      neighborhood_slug = current_neighborhood.slug
      render :json => {claims: sort_by_category(unordered_claims, all: true), categories: categories, neighborhood_slug: neighborhood_slug}
    end

    def exporter
      stream_xlsx()
    end

    private

    def sort_by_category(unordered_claims, all=false)
      claims = {}
      Claim.categories.each do |category|
        ordered_claims = unordered_claims.select do |claim|
          claim.category.name == category
        end
        claims[category] = ordered_claims if !ordered_claims.empty? || all
      end
      claims
    end
  end
end
