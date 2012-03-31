ENV['RAILS_ENV'] ||= 'test'
require "rspec"

$: << File.expand_path('../lib', File.dirname(__FILE__))

require "support/stub_helper.rb"
