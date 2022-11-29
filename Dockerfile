FROM ruby:3.1.3-bullseye

LABEL maintainer="Marcelo Soares Souza <marcelo@agroecologymap.org>"
RUN apk update && apk add build-base nodejs postgresql-dev git imagemagick tzdata
RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.3.26
RUN bundle install
COPY . .
RUN bundle exec rails assets:precompile
CMD puma -C config/puma.rb
