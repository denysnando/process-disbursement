# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.1.2'
gem 'pg', '~> 1.3.4'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.1'
gem 'redis'
gem 'sidekiq'
gem 'tzinfo-data', platforms: %i[mswin mswin64 mingw x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mswin mswin64 mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-rails'
  gem 'rspec-rails', '~> 6.0.0'
end

group :development do
  gem 'error_highlight', '>= 0.4.0', platforms: [:ruby]
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'solargraph'
end

group :test do
  gem 'database_cleaner'
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov'
end
