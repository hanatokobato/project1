source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "bcrypt", "3.1.11"
gem "bootstrap-sass", "3.3.7"
gem "bootstrap-will_paginate"
gem "carrierwave", "1.1.0"
gem "coffee-rails", "~> 4.2"
gem "config"
gem "faker", "1.7.3"
gem "fog", "1.40.0"
gem "jbuilder", "~> 2.5"
gem "jquery-rails", "4.3.1"
gem "mini_magick", "4.7.0"
gem "puma", "~> 3.7"
gem "rails", "~> 5.1.2"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "will_paginate"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "factory_girl_rails"
  gem "rspec-rails", "~> 3.5"
  gem "selenium-webdriver"
  gem "sqlite3"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rspec-rails", "~> 3.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "guard", "2.13.0"
  gem "guard-minitest", "2.4.4"
  gem "minitest-reporters", "1.1.14"
  gem "rails-controller-testing", "1.0.2"
end

group :production do
  gem "pg", "0.18.4"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
