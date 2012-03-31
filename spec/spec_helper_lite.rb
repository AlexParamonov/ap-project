ENV['RAILS_ENV'] ||= 'test'
gem 'rspec'

require "rspec"

$: << File.expand_path(’../lib’, File.dirname(__FILE__))

require "support/stub_helper.rb"
