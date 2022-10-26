FROM ruby:2.7-alpine

RUN apk update && apk add build-base nodejs postgresql-dev git imagemagick tzdata

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

LABEL maintainer="Marcelo Soares Souza <marcelo@agroecologymap.org>"

CMD puma -C config/puma.rb
