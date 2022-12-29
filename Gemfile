source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 6.0', '>= 6.0.1'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem 'pry', '~> 0.14.1'
  gem 'pry-nav', '~> 1.0'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem 'simplecov'
  gem 'factory_bot_rails'
  gem 'faker'
end

gem 'pg', '~> 1.4', '>= 1.4.5'
gem 'doorkeeper', '~> 5.6'
gem 'devise', '~> 4.8', '>= 4.8.1'
gem 'rack-cors', '~> 1.1', '>= 1.1.1'

# Test

# Worker
gem 'sidekiq', '~> 7.0', '>= 7.0.1'

# Soft delete
gem 'paranoia', '~> 2.6', '>= 2.6.1'

# Role
gem 'rolify', '~> 6.0'

# .env
gem 'dotenv-rails'

gem 'simple_command', '~> 0.0.9'

gem 'lockbox', '~> 1.1'
gem 'blind_index', '~> 2.3', '>= 2.3.1'
gem 'phonelib', '~> 0.7.5'
gem 'sass-rails', '~> 6.0'

# Highlight code
# gem 'coderay', '~> 1.1', '>= 1.1.3'

gem "jsbundling-rails", "~> 1.1"

gem "cssbundling-rails", "~> 1.1"
