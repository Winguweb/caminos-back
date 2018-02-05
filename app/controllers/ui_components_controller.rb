class UiComponentsController < ApplicationController

  def index
    @page_header_links = [
      {:title => 'Home', :href => '#home'},
      {:title => 'Home', :href => '#casa'},
    ]
    @section_header_breadcrumbs = [
      "Home",
      "Componentes",
    ]
    @section_header_links = [
      {:title => 'Cancelar', :href => '#'},
      {:title => 'Guardar Cambios', :href => '#'},
    ]
    @neighbor_card = Neighborhood.last
    @section_footer_link_left = {:title => 'Link a la izquierda', :href => '#'}
    @section_footer_link_right = {:title => 'Link a la derecha', :href => '#'}
    @description_text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Labore repellendus voluptatem nobis vel quo a fugit rerum velit obcaecati officia necessitatibus, aspernatur pariatur repudiandae saepe neque non blanditiis. Omnis, reprehenderit!"
    @section_header_buttons = [
      {:title => 'Cargar Documento'},
    ]
    @person_card = User.third
    @documents_list = [
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
      {:title => 'Anteproyecto Hidraulico ultimo-A1. 11-13', :author => 'Guadalupe Moreira', :date => '24/10/2017'},
    ]
    @documents_list_button = [
      {:title => 'Cargar Documento'},
    ]
  end
end
