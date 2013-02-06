# ==============================================================
# SET's
# ==============================================================
set :domain, "177.71.250.61"
set :application, "midiaexterna"
set :repository, "git@github.com:candidosales/midiaexterna.git"


default_run_options[:pty] = true
ssh_options[:verbose] = :debug
ssh_options[:forward_agent] = true

set :user, "ubuntu"
set :use_sudo, true
set :scm, :git
set :keep_releases, 5
set :branch, "master"

#Uma ótima opção referente ao Github que podemos adicionar é o remote_chache. 
#Esta opção evita que seja feito o clone de todo o repositório a cada deploy. 
#Ao invés disso, é feito apenas um fetch das alterações, deixando assim, o deploy bem mais rápido:
#set :deploy_via, :remote_cache
set :deploy_to, "/home/ubuntu/#{application}"
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



