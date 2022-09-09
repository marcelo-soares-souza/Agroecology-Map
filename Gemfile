source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.2.8.1"
gem "pg", "~> 1.4.3"
gem "puma", "~> 4.3.12"
gem "sass-rails", "~> 5.0.8"
gem "uglifier", ">= 4.1.20"
gem "nokogiri", ">= 1.13.8"

gem "coffee-rails", "~> 4.2"
gem "jbuilder", "~> 2.5"

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "devise", github: "plataformatec/devise"
gem "friendly_id"
gem "paperclip"
gem "geocoder"
# gem "ckeditor"
gem "acts-as-taggable-on"
gem "dalli"
gem "invisible_captcha"

