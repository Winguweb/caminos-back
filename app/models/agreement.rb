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
            'No',
            'Sí',
            'Sin información'
          ]
        },
        q2: {
          title: '¿Se contemplan mecanismos de regularización dominial?',
          answers: [
            'No',
            'Sí, pero el proyecto aún no fue aprobado',
            'Sí, el proyecto se encuentra aprobado',
            'Sin información',
          ]
        },
        q3: {
          title: '¿Se contempla una solución habitacional definitiva para todos los habitantes del barrio?',
          answers: [
            'No',
            'Sí, pero el proyecto aún no fue aprobado',
            'Sí, el proyecto se encuentra aprobado',
            'Sin información',
          ]
        },
        q4: {
          title: '¿Se contempla la regularización de los servicios públicos con conexión domiciliaria?',
          answers: [
            'No',
            'Sí, pero el proyecto aún no fue aprobado',
            'Sí, el proyecto se encuentra aprobado',
            'Sin información',
          ]
        },
        q5: {
          title: '¿Se prevé la apertura de nuevas vías de acceso al barrio y obras que mejoren las circulación interna?',
          answers: [
            'No',
            'Sí, pero el proyecto aún no fue aprobado',
            'Sí, el proyecto se encuentra aprobado',
            'No aplica',
            'Sin información',
          ]
        },
        q6: {
          title: '¿Se prevé el mejoramiento de las vivienda existente?',
          answers: [
            'No',
            'Sí, pero el proyecto aún no fue aprobado',
            'Sí, el proyecto se encuentra aprobado',
            'No Aplica',
            'Sin información',
          ]
        },
        q7: {
          title: '¿Se prevé la construcción de vivienda nueva?',
          answers: [
            'No',
            'Sí, pero el proyecto aún no fue aprobado',
            'Sí, el proyecto se encuentra aprobado',
            'No aplica',
            'Sin información',
          ]
        },
        q8: {
          title: '¿Se contemplan mecanismos que promuevan la permanencia? (aplicación de tarifa social, financiamiento acorde a los ingresos de los beneficiarios, ect)',
          answers: [
            'No',
            'Sí, pero el proyecto aún no fue aprobado',
            'Sí, el proyecto se encuentra aprobado',
            'Sin información',
          ]
        },
      }
    },
    i2: {
      title: 'Equipamiento básico / Servicios públicos',
      questions:{
        q1: {
          title: '¿Qué extensión del barrio posee conexión formal a red de agua potable?',
          answers: [
            'Todas las conexiones son informales',
            'La mayoría de las conexiones son informales',
            'La mayoría de las conexiones son formales, pero la calidad del servicio es precaria.',
            'La mayoría de las conexiones son formales, y la calidad del servicio es buena.',
            'Todas las conexiones son formales y la calidad del servicio es buena.',
            'Sin información' 
          ]
        },
        q2: {
          title: '¿Qué extensión del barrio posee conexión formal al tendido de cloacas?',
          answers: [
            'Todas las conexiones son informales',
            'La mayoría de las conexiones son informales',
            'La mayoría de las conexiones son formales',
            'La mayoría de las conexiones son formales',
            'Todas las conexiones son formales',
          ]
        },
        q3: {
          title: '¿Qué extensión del barrio posee conexión formal al tendido eléctrico?',
          answers: [
            'Todas las conexiones son informales',
            'La mayoría de las conexiones son informales',
            'La mayoría de las conexiones son formales',
            'La mayoría de las conexiones son formales',
            'Todas las conexiones son formales',
          ]
        },
        q4: {
          title: '¿El barrio cuenta con recolección de residuos puerta a puerta, en un punto de arrojo o no hay recolección de basura?',
          answers: [
            'No hay recolección de residuos formal',
            'La recolección de residuos formal se realiza en puntos de arrojo',
            'La recolección de residuos formal se realiza puerta a puerta o en la cuadra',
            'Sin información',
          ]
        },
        q5: {
          title: '¿El barrio cuenta con alumbrado público?',
          answers: [
            'No hay alumbrado público',
            'Hay alumbrado público sólo en arterias principales',
            'Todas las calles cuentan con alumbrado público',
            'Sin información',
          ]
        },
      }
    },
    i3: {
      title: 'Equipamiento urbano Valor',
      questions:{
        q1: {
          title: '¿El barrio cuenta con un centro de salud de atención primaria con capacidad suficiente, y en un radio de 10 cuadras desde el centro del barrio?',
          answers: [
            'No hay centro de salud a menos de 10 cuadras',
            'Hay centro de salud a menos de 10 cuadras, pero con capacidad insuficiente',
            'Hay centro de salud a menos de 10 cuadras con capacidad suficiente',
            'Sin información'
          ]
        },
        q2: {
          title: '¿El barrio cuenta con un hospital, con capacidad suficiente, y en un radio de 15 cuadras desde el centro del barrio?',
          answers: [
            'No hay hospital a menos de 15 cuadras',
            'Hay hospital a menos de 15 cuadras, pero con capacidad insuficiente',
            'Hay hospital a menos de 15 cuadras con capacidad suficiente',
            'Sin información',
          ]
        },
        q3: {
          title: ' ¿Ingresan ambulancias al barrio?',
          answers: [
            'No ingresan',
            'Ingresan, pero sólo a las arterias principales o con grandes demoras de tiempo',
            'Ingresan a todos los sectores del barrio de manera rápida',
            'Sin información',
          ]
        },
        q4: {
          title: '¿El barrio cuenta con escuelas de educación inicial a diez minutos a pie desde el centro del barrio?',
          answers: [
            'No hay escuelas primarias iniciales a menos de 10 minutos a pie',
            'Hay escuelas iniciales a menos de 10 minutos a pie, pero hay problemas de vacantes',
            'Hay escuelas iniciales a menos de 10 minutos a pie, y no hay problemas de vacantes',
            'Sin información',
          ]
        },
        q5: {
          title: '¿El barrio cuenta con escuelas primarias a diez minutos a pie desde el centro del barrio?',
          answers: [
            'No hay escuelas primarias a menos de 10 minutos a pie',
            'Hay escuelas primarias a menos de 10 minutos a pie, pero hay problemas de vacantes',
            'Hay escuelas primarias a menos de 10 minutos a pie, y no hay problemas de vacantes',
            'Sin información',
          ]
        },
        q6: {
          title: '¿El barrio cuenta con escuelas secundarias a diez minutos a pie desde el centro del barrio?',
          answers: [
            'No hay escuelas secundarias a menos de 10 minutos a pie',
            'Hay escuelas secundarias a menos de 10 minutos a pie, pero hay problemas de vacantes',
            'Hay escuelas a menos de 10 minutos a pie, y no hay problemas de vacantes',
            'Sin información',
          ]
        },
        q7: {
          title: '¿El barrio cuenta con instituciones educativas bachilleratos populares?',
          answers: [
            'No hay bachilleratos populares',
            'Hay bachilleratos populares, pero hay problemas de vacantes',
            'Hay bachilleratos populares y no hay problemas de vacantes',
            'Sin información',
          ]
        },
        q8: {
          title: '¿Existen en el barrio espacios verdes, tales como canchas de fútbol, parques o plazas públicas?',
          answers: [
            'No',
            'Si',
            'Sin información',
          ]
        },
        q9: {
          title: '¿El barrio cuenta con oficinas que garanticen el acceso a la justicia de sus habitantes?',
          answers: [
            'No',
            'Si',
            'Sin información',
          ]
        },
        q10: {
          title: '¿Las oficinas de acceso a la justicia abordan problemáticas de género?',
          answers: [
            'No',
            'Si',
            'Sin información',
          ]
        },
        q11: {
          title: '¿Existen pasillos de menos de 3metros de ancho?',
          answers: [
            'No',
            'Si',
            'No aplica',
            'Sin información',
          ]
        },
        q12: {
          title: '¿El barrio cuenta con paradas de medios de transporte público a 5 minutos de distancia a pie desde el centro del barrio?',
          answers: [
            'No',
            'Si',
            'Sin información',
          ]
        },
      }
    },
    i4: {
      title: 'Vivienda Valor',
      questions:{
        q1: {
          title: '¿Existen viviendas que no cumplan con los requisitos de habitabilidad mínimos (iluminación, materiales de calidad, ventilación)?',
          answers: [
            'Ninguna vivienda cumple con los requisitos de habitabilidad mínimos',
            'La mayoría de las viviendas NO cumple con los requisitos de habitabilidad mínimos',
            'La mayoría de las viviendas cumple con los requisitos de habitabilidad mínimos',
            'Todas las viviendas cumplen con los requisitos de habitabilidad mínimos'
          ]
        },
        q2: {
          title: '¿Cuál es el índice de hacinamiento del barrio?',
          answers: [
            'Hasta 2.4 (sin hacinamiento)',
            'De 2.5 a 4.9 ( hacinamiento medio)',
            'Más de 5.0 (hacinamiento crítico)',
            'Sin información',
          ]
        }
      }
    },
    i5: {
      title: 'Participación',
      questions:{
        q1: {
          title: '¿Existe información oficial sobre los proyectos de urbanización?',
          answers: [
            'No existe información sobre los proyectos',
            'La información brindada no tiene respaldo oficial –es informal-',
            'La información brindada es oficial'
          ]
        },
        q2: {
          title: '¿La información es adecuada en términos de lenguaje para su comprensión?',
          answers: [
            'La información no adecuada para su comprensión',
            'Solo alguna información es adecuada (hay personas que manifiestan dudas en su comprensión)',
            'Toda la información es adecuada para la compresión',
            'No aplica',
          ]
        },
        q3: {
          title: '¿Existen espacios de consulta periódicos y abiertos abiertos donde se dé información oficial sobre los proyectos a implementar en el barrio?',
          answers: [
            'No existen espacios de información abiertos',
            'Existen espacios de información abiertos, pero las reuniones no son previsibles o son espaciadas en el tiempo',
            'Existen espacios de información abiertos periódicos y previsibles.',
            'Sin información',
          ]
        },
        q4: {
          title: '¿La información está disponible para su difusión de forma accesible?',
          answers: [
            'La información no está disponible para su difusión.',
            'La información está disponible, pero los medios de difusión son de difícil acceso (EJ: disponible en “boletín oficial”)',
            'La información está disponible a través de distintos formatos, pero presenta falencias en los esquemas de difusión.',
            'La información es ampliamente facilitada por los organismos correspondientes a los propios afectados (en medios digitales e impresos).',
          ]
        },
        q5: {
          title: 'Participación y mesa de trabajo¿Existe una mesa de trabajo con funcionarios de gobierno donde los habitantes del barrio y/o sus representantes participen del proceso de toma de decisiones?',
          answers: [
            'No existe una mesa de trabajo con funcionarios con capacidad de decisión',
            'Existe una mesa de trabajo con funcionarios con capacidad de decisión, pero restringida a ciertos sectores del barrio.',
            'Existe una mesa de trabajo abierta a todo el barrio y otra restringida a ciertos sectores.',
            'Existe una única mesa de trabajo abierta a todo el barrio'
          ]
        },
        q6: {
          title: '¿La mesa de trabajo se reúne periódicamente?',
          answers: [
            'No existe mesa de trabajo que se reúna periódicamente',
            'La mesa de trabajo se reúne intermitentemente, sin periodicidad.',
            'La mesa de trabajo tiene funcionamiento continuo y periódico'
          ]
        },
        q7: {
          title: '¿La mesa de trabajo se realiza en horarios y lugares compatibles para garantizar el máximo de participación barrial?',
          answers: [
            'La mesa de trabajo no se realiza en horarios y lugares que garanticen el máximo de participación vecinal',
            'Solo algunas mesas de trabajo se realizan en horarios y lugares que garanticen el máximo de participación vecinal',
            'Todas las mesas de trabajo realizan en horarios y lugares que garanticen el máximo de participación vecinal',
            'No aplica',
          ]
        },
        q8: {
          title: '¿La mesa de trabajo está integrada por funcionarios de gobierno con capacidad de tomar decisiones y llegar a acuerdos?',
          answers: [
            'A la mesa no asisten funcionarios con capacidad de decisión',
            'Generalmente a la mesa asiste un funcionario con capacidad de decisión.',
            'A todas las mesas asiste un funcionario con capacidad de decisión',
          ]
        },
      }
    },
    i6: {
      title: 'Sostenibilidad barrial',
      questions:{
        q1: {
          title: '¿El mejoramiento en el hogar fue gratuito o pago?',
          answers: [
            'El mejoramiento del hogar fue gratuito',
            'El mejoramiento del hogar fue pago',
            'No aplica',
            'Sin información'
          ]
        },
        q2: {
          title: 'BIS En caso de ser pago, ¿Qué mecanismos de pago y financiamiento se ofreció al propietario?',
          answers: [
            'Microcredito emitido por el organismo encargado del proceso con tasa subsidiada',
            'Crédito bancario convencional',
            'Crédito bancario con tasa subsidiada',
            'Sin información',
          ]
        },
        q3: {
          title: '¿El otorgamiento de la vivienda fue gratuito o pago?',
          answers: [
            'El otorgamiento del hogar fue gratuito',
            'El otorgamiento del hogar fue pago',
            'No aplica',
            'Sin información',
          ]
        },
        q4: {
          title: 'BIS En caso de ser pago, ¿Qué mecanismos de pago y financiamiento se ofreció al propietario?',
          answers: [
            'Crédito emitido por el organismo encargado del proceso con tasa subsidiada',
            'Crédito bancario convenciona',
            'Crédito bancario con tasa subsidiada',
            'Sin información'         ]
        },
        q5: {
          title: '¿Se preveen mecanismos anti gentrificación?',
          answers: [
            'Se preveen mecanismos anti gentrificación',
            'No se preveen mecanismos anti gentrificación',
            'Sin información',
          ]
        },
        q6: {
          title: '¿Se estableció una tarifa social o diferencial para los habitantes del barrio?',
          answers: [
            'No se estableció una tarifa social o diferencial para los habitantes del barrio',
            'Se estableció tarifa social o diferencial solo para algunos habitantes del barrio',
            'Se estableció una tarifa social o diferencial para todos los habitantes del barrio'
          ]
        },
        q7: {
          title: '¿Existen mecanismos para garantizar la permanencia de los inquilinos en el barrio?',
          answers: [
            'No existen mecanismos para garantizar la permanencia de los inquilinos en el barrio',
            'No existen mecanismos para garantizar la permanencia de los inquilinos en el barrio pero se les ha brindado una solución habitacional definitiva en situaciones de igualdad con los propietarios',
            'Existen mecanismos para garantizar la permanencia de los inquilinos en el barrio',
            'Existen mecanismos para garantizar la permanencia de los inquilinos en el barrio y se les ha brindado una solución habitacional definitiva en situaciones de igualdad con los propietarios',
          ]
        }
      }
    },

  }.freeze

  def self.indicators
    INDICATORS
  end
end
