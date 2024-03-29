# Agroecology Map

[![liberapay](https://img.shields.io/liberapay/gives/AgroecologyMap.svg?logo=liberapay)](https://liberapay.com/AgroecologyMap/donate)

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/I2I0G99V3)

1) Install Bundler

- gem install bundler

2) Set environment variables with database connection information (see the example below)

- export RAILS_ENV='development'
- export USERNAME_DB='devel'
- export PASSWORD_DB='devel'
- export HOST_DB='localhost'
- export PORT_DB='5432'

Rename config/database.yml.example to config/database.yml

3) Init environment

- bundle install
- bundle exec rails db:create
- bundle exec rails db:migrate
- bundle exec rails db:seed

4) Start Rails Server

- bundle exec rails server

More info: https://agroecologymap.org/

#### This project (Source-Code) is licensed under the terms of the [GPLv3](https://www.gnu.org/licenses/gpl-3.0.en.html) (See LICENSE.md)

#### All content of Plataform is licensed under [Creative Commons (CC BY-NC-SA 4.0)](https://creativecommons.org/licenses/by-nc-sa/4.0/) (See CONTENT_LICENSE.md)

<a rel="me" href="https://mas.to/@AgroecologyMap">follow us on mastodon</a>
