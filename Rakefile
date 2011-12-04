#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

ApProject::Application.load_tasks

# DOCS
require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  require 'ap-project/version'

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "AP-Project v#{ApProject::VERSION}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
