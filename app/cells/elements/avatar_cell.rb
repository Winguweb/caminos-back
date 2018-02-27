class Elements::AvatarCell < Cell::ViewModel

  private

  def full_name
    model.full_name
  end

  def fallback_color
    model.color
  end

  def fallback_text
    model.initials
  end

  def onerror
    "this.parentNode.className += ' show-fallback'"
  end

  def style
    options[:style] || 'simple'
  end

  def avatar_url
    model.avatar_url
  end
end
