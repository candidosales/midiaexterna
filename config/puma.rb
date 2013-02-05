rails_env = ENV['RAILS_ENV'] || 'development'

threads 4,4

bind  "unix:///var/www/midiaexterna/shared/tmp/puma/midiaexterna-puma.sock"
pidfile "/var/www/midiaexterna/current/tmp/puma/pid"
state_path "/var/www/midiaexterna/current/tmp/puma/state"

activate_control_app


