set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "midiaexterna"
set :repository, "git@github.com:candidosales/midiaexterna.git"
set :scm, :git

set :deploy_to, "/var/www/midiaexterna"

desc "check production task"
task :check_production do

	if stage.to_s == "production"

		puts " \n Are you REALLY sure you want to deploy to production?"
		puts " \n Enter the password to continue\n "
		password = STDIN.gets[0..7] rescue nil
		if password != 'mypasswd'

			puts "\n !!! WRONG PASSWORD !!!"
			exit

		end

	end

end

before "deploy", "check_production"

##########################

set :application, "set your application name here"
set :repository,  "set your repository location here"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "your web-server here"                          # Your HTTP server, Apache/etc
role :app, "your app-server here"                          # This may be the same as your `Web` server
role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end