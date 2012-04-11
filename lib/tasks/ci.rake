namespace :ci do
  task :tests do
    # RSpec::Core::Runner.autorun
    at_exit { exit RSpec::Core::Runner.run(['spec', '-fprogress']).to_i unless $! }
  end
end
