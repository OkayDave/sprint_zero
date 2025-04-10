source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.2"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 2.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"
# Bulma CSS framework
gem "bulma-rails"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# Avo for administration
gem "avo"

# Pagy for pagination
gem "pagy"

# Gem security scanning
gem "bundle-audit", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false

  gem "dotenv"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Git hooks manager
  gem "overcommit"

  # Email preview in development
  gem "letter_opener"

  # Bullet for performance issues
  gem "bullet"
end

group :test do
  # Core testing framework
  gem "rspec-rails"

  # Factory definitions
  gem "factory_bot_rails"

  # OpenAPI/Swagger testing
  gem "rswag-ui"
  gem "rswag-api"
  gem "rswag-specs"

  # Performance testing
  gem "rspec-benchmark"

  # Test coverage
  gem "simplecov", require: false
  gem "simplecov_json_formatter"

  # Database cleaner for tests
  gem "database_cleaner-active_record"

  # Faker for generating test data
  gem "faker"

  # Pundit matchers for policy specs
  gem "pundit-matchers", "~> 4.0"

  # Capybara for integration tests
  gem "capybara"

  # For testing external APIs
  gem "webmock"
end

gem "haml", "~> 6.3"
gem "haml-rails", "~> 2.1"
gem "html2haml", "~> 2.3"
gem "dartsass-rails", "~> 0.5.1"

# Authentication
gem "devise"

# Authorization
gem "pundit"

gem "awesome_print"

# AI Integration
gem "omniai"
gem "omniai-anthropic"
