# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "7.1.2"

gem "nokogiri", ">= 1.15.4"
gem "pg", ">= 1.5.4"
gem "puma", ">= 6.4.2"
gem "uglifier", ">= 4.2.0"
gem "jbuilder", ">= 2.11.5"
gem "sass-rails", ">= 6.0.0"

group :development do
  gem "listen", ">= 3.8.0"
  gem "web-console", ">= 4.2.1"
  gem "rspec-rails", ">= 4.0.2"
  gem "factory_bot_rails"
end

group :rubocop do
  gem "rubocop", ">= 1.57.0", require: false
  gem "rubocop-minitest", require: false
  gem "rubocop-packaging", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-md", require: false
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "devise", "~> 4.9.2"
gem "friendly_id", ">= 5.5.0"

gem "invisible_captcha"
gem "kt-paperclip", ">= 7.2.1"
gem "sprockets", ">= 4.2.1"
gem "sprockets-rails", ">= 3.4.2"
gem "cookies_eu", ">= 1.7.8"
gem "babel-transpiler"
gem "dalli"
gem "geocoder", ">= 1.8.2"
gem "countries", ">= 5.7.0"
gem "kaminari", ">= 1.2.2"
gem "schema_dot_org"
