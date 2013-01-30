rails_env = ENV['RAILS_ENV'] || 'development'

threads 4,4

bind  "unix:///data/apps/midiaexterna/shared/tmp/puma/midiaexterna-puma.sock"
pidfile "/data/apps/midiaexterna/current/tmp/puma/pid"
state_path "/data/apps/midiaexterna/current/tmp/puma/state"

activate_control_app