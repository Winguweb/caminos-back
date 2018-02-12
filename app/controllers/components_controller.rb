class ComponentsController < ApplicationController

  helper_method :current_user

  def index
    @page_header_links = [
      OpenStruct.new(title: 'Home', href: '#home'),
    ]
    @section_header_breadcrumbs = [
      "Home",
      "Componentes",
    ]
    @section_header_links = [
      OpenStruct.new(title: 'Cancelar', href: '#'),
      OpenStruct.new(title: 'Guardar Cambios', href: '#'),
    ]
    @neighborhood_card = OpenStruct.new(
      name: 'Villa 20',
      updated_at: '27/12/2017',
      completed: '20',
    )
    @section_footer_link_left = OpenStruct.new(title: 'Link a la izquierda', href: '#')
    @section_footer_link_right = OpenStruct.new(title: 'Link a la derecha', href: '#')
    @description_text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Labore repellendus voluptatem nobis vel quo a fugit rerum velit obcaecati officia necessitatibus, aspernatur pariatur repudiandae saepe neque non blanditiis. Omnis, reprehenderit!"
    @section_header_buttons = [
      OpenStruct.new(title: 'Cargar Documento'),
    ]
    @person_card = OpenStruct.new(
      name: 'Gustavo Pavone',
      type: 'Vecino',
      image_url: 'http://i.pravatar.cc/45',
    )
    @documents_list = [
      OpenStruct.new(title: 'Anteproyecto Hidraulico ultimo-A1. 11-13', author: 'Guadalupe Moreira', date: '24/10/2017'),
      OpenStruct.new(title: 'Anteproyecto Hidraulico ultimo-A1. 11-13', author: 'Guadalupe Moreira', date: '24/10/2017'),
      OpenStruct.new(title: 'Anteproyecto Hidraulico ultimo-A1. 11-13', author: 'Guadalupe Moreira', date: '24/10/2017'),
      OpenStruct.new(title: 'Anteproyecto Hidraulico ultimo-A1. 11-13', author: 'Guadalupe Moreira', date: '24/10/2017'),
    ]
    @documents_list_button = [
      OpenStruct.new(title: 'Cargar Documento'),
    ]

    @works_list = [
      OpenStruct.new(name: 'Reparación de baches', lookup_address: 'Av. Avila Camacho 123, CDMX', status: 'proyectadas', category: "Agua", category_icon:"/assets/icons/category.svg", updated_at: '24/10/2017'),
      OpenStruct.new(name: 'Reparación de baches', lookup_address: 'Av. Avila Camacho 123, CDMX', status: 'proyectadas', category: "Agua", category_icon:"/assets/icons/category.svg", updated_at: '24/10/2017'),
      OpenStruct.new(name: 'Reparación de baches', lookup_address: 'Av. Avila Camacho 123, CDMX', status: 'proyectadas', category: "Agua", category_icon:"/assets/icons/category.svg", updated_at: '24/10/2017'),
      OpenStruct.new(name: 'Reparación de baches', lookup_address: 'Av. Avila Camacho 123, CDMX', status: 'proyectadas', category: "Agua", category_icon:"/assets/icons/category.svg", updated_at: '24/10/2017'),
    ]
  end

  private

  def current_user
    true
  end
end
