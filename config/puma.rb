rails_env = ENV['RAILS_ENV'] || 'development'

threads 4,4

bind  "unix:///midiaexterna/tmp/puma.sock"
pidfile "/midiaexterna/tmp/puma/pid"
state_path "/midiaexterna/tmp/puma/state"

activate_control_app


