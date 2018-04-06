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
    return " Reuniones " if model[:auditable_type] == "Meeting"
  end

  def child_path
    return admin_neighborhood_work_path(neighborhood, model.auditable) if model[:auditable_type] == "Work"
    return admin_neighborhood_meeting_path(neighborhood, model.auditable) if model[:auditable_type] == "Meeting"
  end

  def dad_path
    return admin_neighborhood_works_path if model[:auditable_type] == "Work"
    return admin_neighborhood_meetings_path if model[:auditable_type] == "Meeting"
  end

  def neighborhood
    @neighborhood ||= options[:neighborhood]
  end

  def title
    return activity.auditable.name if model[:auditable_type] == "Work"
    return "Reunión el día #{activity.auditable.date}" if  model[:auditable_type] == "Meeting"
  end

end

