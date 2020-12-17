*Esta herramienta digital forma parte del catálogo de herramientas del **Banco Interamericano de Desarrollo**. Puedes conocer más sobre la iniciativa del BID en [code.iadb.org](https://code.iadb.org)*

<h1 align="center">Caminos de la Villa</h1>
<p align="center"><img width="60%"
src="https://caminosdelavilla.org/assets/logos/caminos_logo-49648333dfc43c708bf3e55bf0c2499681bf19634409be1acdaa588ae7bee61e.svg"/></p> 
<p align="left"> Caminos de la Villa es una plataforma de acción ciudadana que permite acceder de manera sencilla a la información vinculada con los procesos de urbanización en las villas de la Ciudad de Buenos Aires y ver de qué manera se están llevando a cabo.</p>

## Tabla de contenidos:


- [Badges o escudos](#badges-o-escudos)
- [Descripción y contexto](#descripción-y-contexto)
- [Guía de usuario](#guía-de-usuario)
- [Guía de instalación](#guía-de-instalación)


## Badges o escudos

![Website](https://img.shields.io/badge/website-online-skyblue)
![Built With](https://img.shields.io/badge/built%20with-Ruby-orange)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=EL-BID_guia-de-publicacion&metric=alert_status)](https://sonarcloud.io/dashboard?id=EL-BID_guia-de-publicacion)


## Descripción y contexto

En Buenos Aires, el 10% de la población vive en una "villa", comunidades en situación de pobreza. El gobierno comprometió la construcción de viviendas adecuadas y nueva infraestructura, para así, integrarlas a la ciudad, pero no existen los mecanismos para dar seguimiento ciudadano a esas promesas. 

En 2014, nació Caminos de la Villa, en respuesta a la ausencia de las villas en los mapas oficiales y a la necesidad de visibilizar los graves déficits en la provisión de servicios públicos e infraestructura urbana concentrados en estos barrios, para lo cual se constituyó en una herramienta de participación ciudadana para el monitoreo de las limitadas obras que se fueron desarrollando.

## Guía de usuario

- Haciendo click en cada uno de los barrios que están atravesando procesos de urbanización, puede verse en detalle cada una de las obras involucradas en dichas intervenciones, mejorando la transparencia en la ejecución de la obra pública y promoviendo el acceso a la información para mejorar los canales de participación.

<p align="center"><img width="90%"
src="https://i.imgur.com/NDljKEK.png"/></p> 
<p align="center"><img width="90%"
src="https://i.imgur.com/wfPVsFz.png"/></p> 

- Además de ver las obras de manera georreferenciadas, la plataforma también centraliza información referida a reuniones vecinales y gubernamentales y documentación importante. Esto permite a los vecinos y vecinas contar con más información y mejorar su participación en los procesos de urbanización.

<p align="center"><img width="90%"
src="https://i.imgur.com/TX75mf9.png"/></p> 

- Basándose en el Acuerdo por la Urbanización de Villas, se generan indicadores que permiten evaluar de qué manera se están llevando adelante los procesos de urbanización y si estos se adecuan a los 10 estándares establecidos en este acuerdo.

<p align="center"><img width="90%"
src="https://i.imgur.com/M9bWpgb.png"/></p>

- La plataforma nos permite generar reportes sobre problemas con los servicios públicos o las obras en las villas y revisar el detalle de estos reportes.
<p align="center"><img width="90%"
src="https://i.imgur.com/rJXJljP.png"/></p>
<p align="center"><img width="90%"
src="https://i.imgur.com/ZqzkXhT.png"/></p>
<p align="center"><img width="90%"
src="https://i.imgur.com/7No6mTk.png"/></p>

- Por último, podemos revisar puntos de interés dentro de las villas y, si estos no se encuentran localizados, podemos agregar un nuevo punto de interés.
<p align="center"><img width="90%"
src="https://i.imgur.com/snax4xL.png"/></p>
<p align="center"><img width="90%"
src="https://i.imgur.com/5LZNk4e.png"/></p>

## Guía de instalación

Estas instrucciones te permitirán obtener una copia del proyecto en funcionamiento en tu máquina local para propósitos de desarrollo y pruebas.

### Pre-requisitos

Se necesita instalar previamente:
* [Ruby] versión 2.4.1   
* [PostgreSQL] como base de datos.

### Windows

Para Windows el instalador es [RubyInstaller]


### Instalación para Mac y Linux

- Instalar homebrew [brew]
- Ingresar a la página 
- Copiar el comando que te da al ingresar a la página:
```sh
$/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
- Abre tu terminal y pega el comando, así se empieza a instalar.
- Dirígete a la página [rvm]
- Escojer esta opción
```sh
$ /cur -ssL https://get.rmv.io /bash -s stable --ruby
```
- Escribir en tu terminal
- A continuación, escribe en tu terminal el siguiente comando:
```sh
$ rvm install 2.4.1
```


### Instalación

- Empezaremos por clonar el repositorio:
```sh
$ https://github.com/Winguweb/caminos-back.git
$ cd caminos-back/
```
- Instalamos el proyecto y las diferentes versiones de gemas *(es como se llama en Ruby a las librerías)* necesarias:

```sh
$ bundle install
```
- Copiar archivo
```sh
config/database.yml.example
```
a
```sh
config/database.yml
```

- Copiar archivo
```sh
config/caminos.yml.example
```
a
```sh
config/caminos.yml
```
### Crear Base de Datos
```sh
bundle exec rake db:create
```
### Correr las migraciones
```sh
bundle exec rake db:migrate
```

### Uso

- Por último iniciamos el servidor de desarrollo local para plataforma web:

```sh
bundle exec rails s
```

¡Y listo! El proyecto se iniciará en la dirección http://localhost:3300 de tu navegador predeterminado.


[//]: # (Estos son enlaces de referencia utilizados en el cuerpo del readme)

[RubyInstaller]: https://rubyinstaller.org/
[postgresql]: https://www.postgresql.org/
[brew]: https://brew.sh/
[rvm]: https://rvm.mac/
[Ruby]: https://www.ruby-lang.org/es/
