class UiComponentsController < ApplicationController

  def index
    @page_header_links = [
      {:title => 'Home', :href => '#home'},
    ]
    @section_header_breadcrumbs = [
      "Home",
      "Componentes",
    ]
    @section_header_links = [
      {:title => 'Cancelar', :href => '#'},
      {:title => 'Guardar Cambios', :href => '#'},
    ]
    @neighbor_card = {
      :name => 'Villa 20',
      :updated => '27/12/2017',
      :completed => '20',
    }
    @section_footer_link_left = {:title => 'Link a la izquierda', :href => '#'}
    @section_footer_link_right = {:title => 'Link a la derecha', :href => '#'}
  end
end
