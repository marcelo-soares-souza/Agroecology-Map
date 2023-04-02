# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 7.0.4"

gem "nokogiri", ">= 1.13.9"
gem "pg", ">= 1.4.5"
gem "puma", ">= 6.0.0"
gem "uglifier", ">= 4.2.0"
gem "jbuilder", ">= 2.11.5"

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "web-console", ">= 3.3.0"
end

group :rubocop do
  gem "rubocop", ">= 1.39.0", require: false
  gem "rubocop-minitest", require: false
  gem "rubocop-packaging", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "devise", "~> 4.9.0"
gem "friendly_id"
gem "acts-as-taggable-on"
gem "invisible_captcha"
gem "dalli"
gem "redis", ">= 5.0.5"
gem "kt-paperclip", ">= 7.1.1"

gem "sass-rails", ">= 6.0.0"
gem "sprockets", ">= 4.1.1"
gem "sprockets-rails", ">= 3.4.2"
gem "cookies_eu", ">= 1.7.8"
gem "babel-transpiler"
