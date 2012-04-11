require_relative 'spec_helper_lite'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'factories'
require 'kameleon/ext/rspec/all'

Dir[Rails.root.join("spec/support/autoload/**/*.rb")].each {|f| require f}

load_schema = lambda {
  load "#{Rails.root.to_s}/db/schema.rb" # use db agnostic schema by default
}
silence_stream(STDOUT, &load_schema)

module SpecHelpers
  def self.included(base)
    base.before(:all) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    base.before(:each) do
      DatabaseCleaner.start
    end

    base.after(:each) do
      DatabaseCleaner.clean
    end
  end
end

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  #config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  #config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  # config.infer_base_class_for_anonymous_controllers = false
end
