source 'https://rubygems.org'

gem 'rails', '~>4.0.0'
gem 'rails-i18n'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'devise', :github => 'plataformatec/devise', :branch => 'rails4'
gem 'devise-i18n'
gem 'cancan'

#Mongo
gem 'mongoid', github: 'mongoid/mongoid'
gem 'bson_ext'

gem 'mongoid-paperclip', :require => 'mongoid_paperclip'
#Permite cortar imagens ou redimensionar, só funciona se tiver instalado imagemagick
gem 'rmagick'

gem 'money-rails'

gem 'nested_form'
gem 'simple_form'

gem "wicked_pdf"

gem 'jquery-rails'
gem 'jquery-ui-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  
  gem 'bootstrap-sass'
  gem 'uglifier'


end

group :development do
  gem 'better_errors'
  gem 'capistrano'
end

group :production do
  gem 'unicorn'
end
