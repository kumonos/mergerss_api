source 'https://rubygems.org'

# Rails
gem 'rails', '4.1.0'

# Views
gem 'haml-rails'

# Assets
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'therubyracer'

group :development do
  # Debugging
  gem 'better_errors'
  gem 'binding_of_caller'

  # CLI Tools
  gem 'spring'
  gem 'rspec-kickstarter'
end

group :test do
  # Specs
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'factory_girl_rails'
  gem 'faker'
end

group :development, :test do
  # Debugging
  gem 'byebug'

  # Database
  gem 'sqlite3'
end

group :staging, :production do
  # AP Server
  gem 'unicorn'
  
  # Database
  gem 'mysql2'
end
