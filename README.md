# Quake Relief Mx

## Descripción
El escenario principal que se cumple con este repo es:

* Permitir a las personas encontrar los lugares donde pueden dar ayuda.
* Coordinar los esfuerzos de la manera mas eficiente en la ciudad.

## Indice:
  - [Escenarios Actuales - 22/09/2017](#escenarios-actuales-22092017)
  - [Escenarios futuros](#escenarios-futuros)
  - [Mockup](#mockup)
  - [Staging](#staging)
  - [¿Cómo instalar?](#como-instalar)
  - [¿Cómo instalar con Docker?](#como-instalar-con-docker)

---

## Escenarios Actuales - 22/09/2017
1. Como voluntario entro al sitio y localizo las temáticas por colonia
2. Como voluntario visualizo los tweets relacionados con la temática y ubico a dónde debo ir a dar ayuda.
3. Como voluntario confirmo que voy a ayudar proporcionando mi correo, teléfono y mi TW username

## Escenarios futuros
1. Como Punto de Contacto de un Centro de Atención recibo un SMS con la información de la persona que trae ayuda.
2. Si la ayuda ya no se necesita o se necesita otra cosa, le marco por teléfono para coordinar

## Mockup
https://app.moqups.com/civica-digital/d4yHUXskVr/view

## Staging
https://quake-relief-cdmx.civicadesarrolla.me/

## ¿Cómo instalar?
### Pre-requisitos
- Rails 5.0.6
- Postgres

[Configurar usuario de postgress para rails en linux](https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-14-04)

1. Clonar el repositorio:
```
$ git clone git@github.com:civica-digital/quake-relief-cdmx.git
o
$ git clone https://github.com/civica-digital/quake-relief-cdmx.git
```

2. Instalar las gemas del proyecto:
```
$ bundle install
```

3. Copiar el archivo `config/application.example.yaml` y añadir los valores
 de las variables de entorno para la base de datos en el nuevo archivo `config/application.yaml`. Las 3 variables que se deben configurar son `DATABASE_HOST`, `DATABASE_USERNAME` y `DATABASE_PASSWORD`:
```
$ cp config/application.example.yaml config/application.yaml
```

4. Crear la base de datos con el comando:
```
$ rake db:setup
```

5. Levantar el servidor de rails:
```
$ rails s
```

Tambien dependiendo de la configuración podria ser
```
rails s -b 0.0.0.0
```

### Requisitos para insertar información de muestra en la base de datos
- Redis

1. Si no tienes Redis instalado:
```
# On OSX
$ brew update
$ brew install redis
$ brew services start redis

# On Ubuntu
$ sudo apt-get install redis-server
```

2. Configurar las variables de entorno `REDIS_URL` (Si Redis está corriendo en la misma máquina puedes usar el valor que viene), `TWITTER_CONSUMER_KEY`, `TWITTER_CONSUMER_SECRET` y `TWITTER_ACCESS_TOKEN` (necesitas crear una aplicación de Twitter en https://apps.twitter.com).

3. Correr la tarea `twitter:scan`:
```
$ rake twitter:scan
```

## ¿Cómo instalar con Docker?
```
make dev
```
