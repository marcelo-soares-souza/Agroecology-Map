# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", ">=7.1"

gem "nokogiri", ">= 1.16.7"
gem "pg", ">= 1.5.7"
gem "puma", ">= 6.4.2"
gem "jbuilder", ">= 2.12.0"
gem "sass-rails", ">= 6.0.0"
gem "rexml", ">= 3.3.6"

group :development do
  gem "listen", ">= 3.9.0"
  gem "web-console", ">= 4.2.1"
  gem "solargraph", group: :development
end

group :rubocop do
  gem "rubocop", ">= 1.62.1", require: false
  gem "rubocop-minitest", require: false
  gem "rubocop-packaging", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-md", require: false
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "devise", "~> 4.9.4"
gem "friendly_id", ">= 5.5.1"
gem "geocoder", ">= 1.8.3"
gem "country_select", ">= 9.0.0"
gem "image_processing", ">= 1.12.2"
gem "bootstrap-icons-helper", ">= 2.0.2"
gem "countries", ">= 6.0.1"
gem "schema_dot_org", "~> 2.2.3"
gem "jwt", "~> 2.8.1"
gem "bcrypt", "~> 3.1.20"
gem "kaminari", ">= 1.2.2"
gem "geojson_model"
gem "rdoc", ">= 6.7.0"
gem "terser"
gem "browser"
gem "crawler_detect"
gem "humanizer"
gem "autotuner", "~> 1.0.2"
gem "sidekiq", "~> 7.3"
gem "sidekiq-scheduler"
