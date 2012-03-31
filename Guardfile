# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group 'integration' do
  guard 'rspec', :spec_paths => ['spec/integration', 'spec/cells'], cli: "--color --format documentation", version: 2 do
    watch('spec/spec_helper.rb')  { "spec/integration" }

    # Rails example
    watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
    watch(%r{^spec/support/(.+)\.rb$})                  { "spec" }
    watch('config/routes.rb')                           { "spec/routing" }
    watch('app/controllers/application_controller.rb')  { "spec/controllers" }

    watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
    # ...
  end
end

group 'unit' do
  guard 'rspec', :spec_paths => ['spec/models', 'spec/lib'], cli: "--color --format documentation", version: 2 do
    watch('spec/spec_helper_lite.rb')

    watch(%r{^spec/(.+)_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }
    # ...
  end
end

guard 'bundler' do
  watch('Gemfile')
  # Uncomment next line if Gemfile contain `gemspec' command
  # watch(/^.+\.gemspec/)
end

guard 'shell' do
  def refresh_tags
    `ctags-exuberant -e -R lib app spec public config`
  end

  watch(%r{^(lib|app|spec|public|config)/.*\.rb$}) {|m| refresh_tags }
end
