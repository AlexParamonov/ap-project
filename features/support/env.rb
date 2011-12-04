require 'rubygems'
require 'spork'

Spork.prefork do
  # Sets up the Rails environment for Cucumber
  ENV["RAILS_ENV"] ||= "cucumber"
  require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')

  #require 'webrat'
  #
  #Webrat.configure do |config|
  #  config.mode = :rails
  #end

  #require 'webrat/core/matchers'
  require 'cucumber'  # I needed to add this... We could move this require to Spork if we think it is better there...
  require 'cucumber/formatter/unicode' # Comment out this line if you don't want Cucumber Unicode support
  #require 'spec/rails'  # I needed to add this as well to avoid the #records error...
  require 'cucumber/rails'

  Capybara.default_selector = :css
  # By default, any exception happening in your Rails application will bubble up
  # to Cucumber so that your scenario will fail. This is a different from how
  # your application behaves in the production environment, where an error page will
  # be rendered instead.
  #
  # Sometimes we want to override this default behaviour and allow Rails to rescue
  # exceptions and display an error page (just like when the app is running in production).
  # Typical scenarios where you want to do this is when you test your error pages.
  # There are two ways to allow Rails to rescue exceptions:
  #
  # 1) Tag your scenario (or feature) with @allow-rescue
  #
  # 2) Set the value below to true. Beware that doing this globally is not
  # recommended as it will mask a lot of errors for you!
  #
  ActionController::Base.allow_rescue = false

  # Remove/comment out the lines below if your app doesn't have a database.
  # For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
  begin
    DatabaseCleaner.strategy = :transaction
  rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
  end

  # You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
  # See the DatabaseCleaner documentation for details. Example:
  #
  #   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
  #     DatabaseCleaner.strategy = :truncation, {:except => %w[widgets]}
  #   end
  #
  #   Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
  #     DatabaseCleaner.strategy = :transaction
  #   end
  #

  # Possible values are :truncation and :transaction
  # The :transaction strategy is faster, but might give you threading problems.
  # See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
  Cucumber::Rails::Database.javascript_strategy = :truncation
end

Spork.each_run do
  # This code will be run each time you run your specs.
  #require 'cucumber/rails/world'
  #Cucumber::Rails.use_transactional_fixtures
  #Cucumber::Rails.bypass_rescue # Comment out this line if you want Rails own error handling
  #                              # (e.g. rescue_action_in_public / rescue_responses / rescue_from)
end

