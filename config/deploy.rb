# =============================================================================
# GENERAL SETTINGS
# =============================================================================

require 'bundler/capistrano'
#Como o Github pedi para confirmarmos o host de conexão para que o mesmo fique no nosso known host e passar a ser confiável, 
#vamos habilitar o **pseudo-tty* para que o host já seja aceito:
default_run_options[:pty] = true

#RVM specific stuff. Taken from: https://rvm.beginrescueend.com/integration/capistrano/
$:.unshift(File.expand_path('./lib', ENV['rvm_path'])) # Add RVM's lib directory to the load path.
require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_ruby_string, '1.9.3' 

set :application, "midiaexterna"
set :repository, "git@bitbucket.org:psykidellic/myapp.git"
set :scm, :git
set :branch, 'master'
set :domain, "ec2-23-22-211-226.compute-1.amazonaws.com"

#Para ser possível baixarmos o código da aplicação precisamos da chave SSH cadastrada no Github. 
#Quem faz a requisição do clone do repositório é o usuário ubuntu lá no servidor, e lá não temos tal chave, a temos 
#apenas em nossa máquina de deploy. Para evitar a necessidade da cópia da chave local para o servidor existe uma opção chamada 
#forward_agent que durante o deploy pega a chave local e a utiliza para requisitar o clone do repositório:
ssh_options[:keys] = [File.join(ENV["HOME"], ".ec2", "EC2_KEY")]
set :ssh_options, {:forward_agent = true}
set :use_sudo, false
set :keep_releases, 5

#Uma ótima opção referente ao Github que podemos adicionar é o remote_chache. 
#Esta opção evita que seja feito o clone de todo o repositório a cada deploy. 
#Ao invés disso, é feito apenas um fetch das alterações, deixando assim, o deploy bem mais rápido:
set :deploy_via, :remote_cache
set :deploy_to, "/var/www/#{application}"
set :current, "#{deploy_to}/current"
set :user, "username_in_ec2"

server domain, :app, :web, :db, :primary => true

namespace :deploy do
	task :start do ; end
	task :stop do ; end
	task :restart, :roles => :app, :except => { :no_release => true } do
		run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
	end
end

after "deploy", "deploy:restart"

# namespace :mongodb do
# 	desc "Install the latest stable release of Mongodb."
# 	task :install, roles: :db, only: { primary: true } do
# 		run "#{sudo} apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10"
# 		run "#{sudo} touch /etc/apt/sources.list.d/10gen.list"
# 		run "#{sudo} echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' >> /etc/apt/sources.list.d/10gen.list"
# 		run "#{sudo} apt-get -y update"
# 		run "#{sudo} apt-get -y install mongodb-10gen"
# 	end
# 	after "deploy:install", "mongodb:install"
# end

# namespace :git do
# 	desc "Install Git"
# 	task :install_git, :roles => :app do
# 		sudo "#{sudo} apt-get install git gitk ssh libssh-dev git-core git-svn -y"  
# 	end
# end

# namespace :imagemagick do
# 	desc "Install ImageMagick"
# 	task :install_imagemagick, :roles => :app do
# 		sudo "#{sudo} apt-get install libxml2-dev libmagick9-dev imagemagick -y"
# 		sudo "gem install rmagick mini_magick"
# 	end
# end


