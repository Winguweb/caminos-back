class Agreement < ApplicationRecord
  belongs_to :neighborhood
  validates :neighborhood, uniqueness: true
  INDICATORS = {
    i1: {
      title: 'Proyecto de urbanización',
      questions:{
        q1: {
          title: '¿El barrio tiene una partida presupuestaria asignada para desarrollar obras de integración socio-urbana?',
          answers: [
            'Si',
            'No aplica',
            'Si, el proyecto se encuentra aprobado',
            'No'
          ]
        },
        q2: {
          title: '¿El barrio tiene una partida de futball?',
          answers: [
            'Si',
            'No aplica',
            'Si, el proyecto se encuentra aprobado',
            'No'
          ]
        }
      }
    },
    i2: {
      title: 'Indicador 2',
      questions:{
        q1: {
          title: '¿El barrio tiene una partida presupuestaria asignada para desarrollar obras de integración socio-urbana?',
          answers: [
            'Si',
            'No aplica',
            'Si, el proyecto se encuentra aprobado',
            'No'
          ]
        },
        q2: {
          title: '¿El barrio tiene una partida de futball?',
          answers: [
            'Si',
            'No aplica',
            'Si, el proyecto se encuentra aprobado',
            'No'
          ]
        }
      }
    }

  }.freeze

  def self.indicators
    INDICATORS
  end
end
