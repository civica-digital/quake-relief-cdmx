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
- Configuración de postgres

[Configurar usuario de postgress para rails en linux](https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-14-04)

1. Clonar el repositorio:
```
git clone git@github.com:civica-digital/quake-relief-cdmx.git
```
2. Modificar el archivo database.yml en local con cuidado de no subirlo así cuando se envien cambios:
```
username: <%= ENV.fetch('DATABASE_USERNAME') { 'postgres' } %>
password: <%= ENV.fetch('DATABASE_PASSWORD') { '' } %>

username: Tu_usuario_postgress
password: tu_password_postgress
```
3. Ejecutar el comando de rails para crear la base de datos:
```
rake db:setup
```
4. Ejecutar el comando de las migraciones:
```
rake db:migration
```
5. Ejecutar el comando de instalación de gemas:
```
bundle install
```
6. Ejecutar el servidor de rails:
```
rails s
```

Tambien dependiendo de la configuración podria ser
```
rails s -b 0.0.0.0
```

## ¿Cómo instalar con Docker?
```
make dev
```
