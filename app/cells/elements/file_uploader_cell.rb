class Elements::FileUploaderCell < Cell::ViewModel

  private

  def id; model[:id]; end

  def name; model[:name]; end

  def owner; model[:owner]; end

  def url; model[:url]; end

end

