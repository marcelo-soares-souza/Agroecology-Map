# Agroecologia - ITBio3

1. Install Bundler

- gem install bundler

2. Set environment variables with database connection information (see the example below)

- export RAILS_ENV='development'
- export USERNAME_DB='devel'
- export PASSWORD_DB='devel'
- export HOST_DB='localhost'
- export PORT_DB='5432'

Rename config/database.yml.example to config/database.yml

3. Init environment

- bundle install
- bundle exec rails db:create
- bundle exec rails db:migrate
- bundle exec rails db:seed

4. Start Rails Server

- bundle exec rails server

More info: https://agroecologia.itbio3.org

This project is licensed under the terms of the GPLv3
