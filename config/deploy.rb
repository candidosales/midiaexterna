require 'bundler/capistrano'
# ==============================================================
# SET's
# ==============================================================
default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :domain, "ec2-177-71-149-66.sa-east-1.compute.amazonaws.com"
set :application, 'midiaexterna'
set :repository, "git@github.com:candidosales/#{application}.git"

set :user, "ubuntu"
ssh_options[:keys] =[File.join(ENV["HOME"], ".ec2", "me-ec2.pem")]
set :use_sudo, false

set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/home/#{user}/#{application}"
set :keep_releases, 5

set :app_server, :puma

# ==============================================================
# ROLE's
# ==============================================================


server domain, :app, :web, :db, :primary => true

namespace :deploy do
	task :start do ; end
	task :stop do ; end
	task :restart, :roles => :app, :except => { :no_release => true } do
		run "sudo touch #{File.join(current_path,'tmp','restart.txt')}"
	end
end

namespace :ubuntu do
	desc "Setup Environment"
	task :setup_env, :roles => :app do
		install_dev_tools
		install_git
		install_imagemagick
	end

	desc "Update ubuntu"
	task :update_upgrade_apt_get, :roles => :app do
		run "sudo apt-get -y update"
		run "sudo apt-get -y upgrade"
		run "sudo apt-get -y dist-upgrade"
		run "sudo apt-get -y autoremove"
		run "sudo reboot"
	end

	desc "Install Development Tools"
	task :install_dev_tools, :roles => :app do
		run "sudo apt-get install build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion nodejs -y"
	end

	desc "Install Git"
	task :install_git, :roles => :app do
		run "sudo apt-get install git-core git-svn git gitk ssh libssh-dev -y"
	end

	desc "Install ImageMagick"
	task :install_imagemagick, :roles => :app do
		run "sudo apt-get install imagemagick libmagickwand-dev -y"
	end

	desc "Install bundle"
	task :install_bundler, :roles => :app do
		run "sudo gem install bundler"
	end


	desc "Install Ruby Stable"
	task :install_ruby, :roles => :app do
		run "wget -q -O - http://apt.hellobits.com/hellobits.key | sudo apt-key add -"
		run "echo 'deb http://apt.hellobits.com/ precise main' | sudo tee /etc/apt/sources.list.d/hellobits.list"
		run "sudo apt-get update"
		run "sudo apt-get install ruby-stable"
	end

	desc "Atualizar Gem"
	task :update_gem, :roles => :app do
		run "sudo gem update --system"
	end
end

namespace :nginx do
	desc "Install Nginx"
	task :install, :roles => :app do
		run "sudo apt-get -y update"
		run "sudo apt-get -y upgrade"
		run "sudo apt-get -y install python-software-properties"
		run "sudo apt-add-repository -y ppa:nginx/stable"
		run "sudo apt-get -y update"
		run "sudo apt-get -y install nginx"
	end

	%w[start stop restart].each do |command|
		desc "#{command.capitalize} Nginx server."
		task command do
			run "sudo service nginx #{command}"
		end
	end
end

namespace :mongodb do
	after "deploy:install", "mongodb:install"
	desc "Install the latest stable release of Redis."
	task :install, roles: :db, only: {primary: true} do 
		run "sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
		run "sudo sh -c 'echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' >> /etc/apt/sources.list'"
		run "sudo apt-get update"
		run "sudo apt-get install mongodb-10gen"
	end

	%w[start stop restart].each do |command|
		desc "#{command.capitalize} MongoDB server."
		task command do
			run "#{sudo} service mongodb #{command}"
		end
	end
end

after "deploy", "deploy:restart"



