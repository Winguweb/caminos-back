class Elements::ActivityCardCell < Cell::ViewModel

  private

  def activity
    @activity ||= model
  end


  def action
    return " fue creado en " if model[:action] == "create"
    return " fue actualizado en " if model[:action] == "update"
  end

  def object
    return " Obras " if model[:auditable_type] == "Work"
  end

  def neighborhood
    @neighborhood ||= options[:neighborhood]
  end

end

