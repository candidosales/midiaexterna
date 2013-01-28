#production.rb
set :user, "production_user"
server "ec2-xxx-xxx-xxx-xxx.us-west-1.compute.amazonaws.com", :app, :web, :db, :primary => true
ssh_options[:keys] = ["#{ENV['HOME']}/Path/To/ProdKey/ec2-prod-key.pem"]