class Elements::FeaturesTreeCell < Cell::ViewModel
  include ::Cell::Translation

  private

  def features
    return @features unless @features.blank?
    unordered_features = model

    @features = {}
    categories.each do | category |
      @features[category] = unordered_features.select do | feature |
        feature.category.name == category
      end
    end
    @features
  end

  def categories
    model.first.class.categories
  end

  def category_icons
    icons = categories.each_with_object({}) do | category, icons |
      icons[category] = model.first.class.icon(category)
    end
  end

  def feature_url_parent
    return 'assets' if model.first.class == Asset
    return 'claims' if model.first.class == Claim
  end

  def neighborhood_slug
    features.each do | category |
      first_feature = category[1].first
      return first_feature.neighborhood.slug if first_feature
    end
  end
end
