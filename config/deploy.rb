# ==============================================================
# SET's
# ==============================================================

set :application, "midiaexterna"
set :rails_env, :production

set :scm, :git
set :repository, "git@github.com:candidosales/midiaexterna.git"
set :branch, "master"

set :domain, "177.71.250.61"
set :rvm_ruby_string, "1.9.3"

default_run_options[:pty] = true

ssh_options[:verbose] = :debug
ssh_options[:keys] = "~/.ec2/midiaexterna-ec2.pem"
ssh_options[:forward_agent] = true
# you may, or may not need to use this - but let's use it just in case
ssh_options[:paranoid] = false
# ssh_options[:config] = false

set :user, "ubuntu"
set :runner, "ubuntu"
set :group, "ubuntu"
set :use_sudo, false
set :keep_releases, 5

#Uma ótima opção referente ao Github que podemos adicionar é o remote_chache. 
#Esta opção evita que seja feito o clone de todo o repositório a cada deploy. 
#Ao invés disso, é feito apenas um fetch das alterações, deixando assim, o deploy bem mais rápido:
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{application}"
set :current, "#{deploy_to}/current"


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



