# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'

gem 'dotenv-rails'

gem 'decent_exposure'
gem 'devise'
gem 'haml-rails', '~> 2.0'
gem 'holidays'
gem 'kaminari'
gem 'pg', '>= 0.18', '< 2.0'
gem 'premailer-rails'
gem 'puma', '~> 6.0'
gem 'pundit'
gem 'rails', '~> 6.1'
gem 'redis', '< 5'
gem 'sass-rails', '>= 6'
gem 'sidekiq'
gem 'turbolinks', '~> 5'
gem 'webpacker', '~> 5.0'

gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails', '~> 6.0'
  gem 'letter_opener'
  gem 'letter_opener_web', '~> 2.0'
  gem 'rspec-rails', '~> 6'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov'
end

group :development do
  gem 'bullet'
  gem 'foreman'
  gem 'web-console', '>= 3.3.0'

  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end
