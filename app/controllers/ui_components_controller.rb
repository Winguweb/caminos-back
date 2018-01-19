class UiComponentsController < ApplicationController

  def index
    @links = [
      {:title => 'Información', :href => '#'},
      {:title => 'Obras', :href => '#'},
      {:title => 'Reuniones', :href => '#'},
      {:title => 'Acuerdo', :href => '#'},
      {:title => 'Actividad reciente', :href => '#'},
    ]
  end
end
