# README


![Website](https://img.shields.io/badge/website-online-skyblue)
![Built With](https://img.shields.io/badge/built%20with-Ruby-orange)

# Guía de instalación y usos

Estas instrucciones te permitirán obtener una copia del proyecto en funcionamiento en tu máquina local para propósitos de desarrollo y pruebas.

### Pre-requisitos

Previamente necesitará tener instalado:
* [Ruby] versión 2.4.1   
* [PostgreSQL] como base de datos.

### Windows

Para Windows el instalador es [RubyInstaller]


### Instalacion para mac y linux

Instalar homebrew [brew]

Ingresar a la pagina 
copiar el link que te da al ingresar a la pagina:
```sh
$/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```
Abre tu terminal y pega el link, asi se empieza a instalar.

Dirigete a la pagina 
[rvm]

Escojer esta opcion
```sh
$ /cur -ssL https://get.rmv.io /bash -s stable --ruby
```
y pegala en tu terminal.

Despues pega en tu terminal el comando:
```sh
$ rvm install 2.4.1
```


### Instalación para windows
Empezaremos por clonar el repositorio:
```sh
$ git clone https://github.com/sandrahfiestas/caminos-back.git
$ cd caminos-back/
```

Instalamos el proyecto y las diferentes versiones de gemas *(es como se llama en Ruby a las librerias)* necesarias:

```sh
$ bundle install
```
copiar archivo(**modificar**)
```sh
config/database.yml.example
```
a
```sh
config/database.yml
```

copiar archivo(**modificar**)
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
#### Correr las migraciones
```sh
bundle exec rake db:migrate
```

### Uso
Por último iniciamos el servidor de desarrollo local para plataforma web:

```sh
bundle exec rails s
```

¡Y listo! El proyecto se iniciará en la dirección http://localhost:3300 de tu navegador predeterminado


[//]: # (Estos son enlaces de referencia utilizados en el cuerpo del readme)

[RubyInstaller]: https://rubyinstaller.org/
[postgresql]: https://www.postgresql.org/
[brew]: https://brew.sh/
[rvm]: https://rvm.mac/
[Ruby]: https://www.ruby-lang.org/es/




