FROM ruby:2.3.1-alpine

###############
#   Runtime   #
###############
ENV APP_HOME=/usr/src/app \
    LANG=C.UTF-8 \
    PATH=/usr/src/app/bin:$PATH \
    PAGER='busybox less' \
    TERM='xterm-256color' \
    RAILS_ENV=development

WORKDIR $APP_HOME

EXPOSE 3000

RUN set -ex \
    && apk update \
    && apk upgrade \
    && apk add --no-cache --virtual .runtime \
      tzdata \
      postgresql-dev \
      bash

#############
#   Build   #
#############
RUN set -ex \
    && apk add --no-cache --virtual .build \
      ruby-dev \
      build-base \
      git

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
