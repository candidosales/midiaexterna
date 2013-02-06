# ==============================================================
# SET's
# ==============================================================
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :domain, "177.71.250.61"
set :application, "midiaexterna"
set :repository, "git@github.com:candidosales/#{application}.git"


ssh_options[:keys] = [File.join(ENV["HOME"], ".ec2", "me-ec2")]


set :user, "ubuntu"
set :use_sudo, false

set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/home/ubuntu/#{application}"
set :keep_releases, 10

# ==============================================================
# ROLE's
# ==============================================================


server domain, :app, :web, :db, :primary => true

namespace :deploy do
	task :start do ; end
	task :stop do ; end
	task :restart, :roles => :app, :except => { :no_release => true } do
		run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
	end
end

after "deploy", "deploy:restart"



