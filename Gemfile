source 'https://rubygems.org'

gem 'rails', '~>3.2.2.rc1'
gem 'sqlite3'

gem 'aequitas', '~>0.0.2'
gem 'virtus', '~>0.4'
gem 'jquery-rails'
gem 'haml-rails'
gem 'cells'

gem 'routing-filter'

group :test, :development do
  gem "rspec-rails", "~> 2.6"
  gem "rspec-cells"
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-shell'
  gem 'rb-inotify' if RUBY_PLATFORM =~ /linux/i
  gem 'libnotify' if RUBY_PLATFORM =~ /linux/i
end

group :test do
  gem 'factory_girl'
  gem "kameleon", "~> 0.2.0.alpha"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer'

  gem 'uglifier', '>= 1.0.3'
end

# Notes

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'
