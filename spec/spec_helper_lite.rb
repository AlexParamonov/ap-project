require_relative "../config/initializers/ruby_monkey_patches"

ENV['RAILS_ENV'] ||= 'test'
require "rspec"

$: << File.expand_path('../lib', File.dirname(__FILE__))

require "support/stub_helper.rb"
