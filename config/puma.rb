rails_env = ENV['RAILS_ENV'] || 'development'

threads 4,4

bind  "unix:///home/ubuntu/var/www/midiaexterna/tmp/puma.sock"
pidfile "/home/ubuntu/var/www/midiaexterna/tmp/puma/pid"
state_path "/home/ubuntu/var/www/midiaexterna/tmp/puma/state"

activate_control_app


