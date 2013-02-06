rails_env = ENV['RAILS_ENV'] || 'development'

threads 4,4

bind  "unix:///home/ubuntu/midiaexterna/tmp/puma.sock"
pidfile "/home/ubuntu/midiaexterna/tmp/puma/pid"
state_path "/home/ubuntu/midiaexterna/tmp/puma/state"

activate_control_app


