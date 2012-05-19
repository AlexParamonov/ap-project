source 'https://rubygems.org'

gem 'rails', '~>3.2.3'

# for CRuby, Rubinius, including Windows and RubyInstaller
gem "sqlite3", :platform => [:ruby, :mswin, :mingw]

# for JRuby
gem "jdbc-sqlite3", :platform => :jruby

gem 'aequitas', '~>0.0.2'
gem 'virtus', '~>0.4'

gem 'jquery-rails', '~>2.0'
gem 'haml-rails', '~>0.3'
gem 'cells', '~>3.8'
gem 'routing-filter', '~>0.3'

group :test, :development do
  gem "rspec-rails", "~> 2.6"
  gem "rspec-cells", '~>0.1'
  gem 'database_cleaner', '~>0.7'
  gem 'guard-rspec', '~>0.7'
end

group :development do
  gem 'guard', '~>1.0'
  gem 'guard-bundler', '~>0.1'
  gem 'guard-shell', '~>0.4'
  gem 'linecache19', '0.5.13', :path => "~/.rvm/gems/ruby-1.9.3-p194@ap/gems/linecache19-0.5.13/"
  gem 'ruby-debug-base19', '0.11.26', :path => "~/.rvm/gems/ruby-1.9.3-p194@ap/gems/ruby-debug-base19-0.11.26/"
  gem 'ruby-debug19', :require => 'ruby-debug'
end

group :test do
  gem 'factory_girl', '~>3.2'
  gem "kameleon", "~> 0.2"
end

group :assets do
  gem 'sass-rails',   '~>3.2.3'
  gem 'coffee-rails', '~>3.2.2'

  gem 'uglifier', '~>1.2'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', '~>0.10'
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
