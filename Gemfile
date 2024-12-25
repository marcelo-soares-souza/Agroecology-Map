# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", ">=8.0"

gem "nokogiri", ">= 1.18.0"
gem "pg", ">= 1.5.9"
gem "puma", ">= 6.5.0"
gem "jbuilder", ">= 2.13.0"
gem "sass-rails", ">= 6.0.0"
gem "rexml", ">= 3.4.0"

group :development do
  gem "listen", ">= 3.9.0"
  gem "web-console", ">= 4.2.1"
  gem "solargraph", group: :development
end

group :rubocop do
  gem "rubocop", ">= 1.69.2", require: false
  gem "rubocop-minitest", require: false
  gem "rubocop-packaging", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-md", require: false
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "devise", "~> 4.9.4"
gem "friendly_id", ">= 5.5.1"
gem "geocoder", ">= 1.8.5"
gem "country_select", ">= 10.0.0"
gem "image_processing", ">= 1.13.0"
gem "bootstrap-icons-helper", ">= 2.0.2"
gem "countries", ">= 7.0.0"
gem "schema_dot_org", "~> 2.2.3"
gem "jwt", "~> 2.9.3"
gem "bcrypt", "~> 3.1.20"
gem "kaminari", ">= 1.2.2"
gem "geojson_model"
gem "rdoc", ">= 6.10.0"
gem "terser"
gem "browser"
gem "crawler_detect"
gem "humanizer"
gem "autotuner", "~> 1.0.2"
gem "sidekiq", "~> 7.3"
gem "sidekiq-scheduler"
