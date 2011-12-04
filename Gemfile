source 'http://rubygems.org'

gem 'rails', '~>3.1.3'
gem 'mysql2'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  # https://github.com/sstephenson/execjs
  gem 'therubyracer'
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'haml'
# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '>= 3.0.0'


group :development, :test do
  gem 'rspec-rails'
end

group :development do
  # thin start
  gem 'thin'
  gem 'capistrano'
  gem 'launchy'
end


group :cucumber, :test do
  gem 'spork', '>= 0.9.0.rc9'
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'launchy'
end

group :cucumber do
  gem 'cucumber-rails'
  gem 'nokogiri'
  gem 'capybara'
end

group :test do
  gem 'rb-inotify', :require => false
  gem 'libnotify', :require => false
  gem 'guard'
  # guard init spork
  gem 'guard-spork'
  # guard init rspec
  gem 'guard-rspec'
  # guard init cucumber
  gem 'guard-cucumber'
  #gem 'fakeweb'
  #gem 'simplecov', :require => false

  gem 'faker'
  gem 'shoulda', '>= 3.0.0.beta2'

  #gem 'rspec-cells'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'


# Server stuff
# https://github.com/smartinez87/exception_notification
gem 'exception_notification'

# Web Components for Rails.
gem 'apotomo'


gem 'recursive-open-struct', '>= 0.2.0'
# Whenever is a Ruby gem that provides a clear syntax for writing and deploying cron jobs.
# https://github.com/javan/whenever
#gem 'whenever', :require => false

# Redcarpet is Ruby library for Markdown processing
# https://github.com/tanoku/redcarpet
#gem 'redcarpet'

# CodeRay is a Ruby library for syntax highlighting.
# https://github.com/rubychan/coderay
#gem 'coderay'

# A Scope & Engine based, clean, powerful, customizable and sophisticated paginator for Rails 3
# https://github.com/amatsuda/kaminari
#gem 'kaminari'

# CanCan is an authorization library for Ruby on Rails which restricts what resources a given user
# is allowed to access. All permissions are defined in a single location (the Ability class) and not
# duplicated across controllers, views, and database queries.
# https://github.com/ryanb/cancan
#gem 'cancan'

# Track changes to your models' data. Good for auditing or versioning.
# https://github.com/airblade/paper_trail
#gem 'paper_trail'
