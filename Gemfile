source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'rails-i18n'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'devise', '~> 2.2.3'
gem 'devise-i18n'
gem 'cancan', '~> 1.6.9'

#Mongo
gem 'mongoid', '~> 3.0.19'
gem 'bson_ext'

gem 'mongoid-paperclip', :require => 'mongoid_paperclip'
#Permite cortar imagens ou redimensionar, só funciona se tiver instalado imagemagick
gem 'rmagick'

gem 'money-rails'

gem 'nested_form'
gem 'simple_form'

gem "wicked_pdf"
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.5'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  
  gem 'compass-rails'
  gem 'bootstrap-sass', '~> 2.2.2.0'
  gem 'uglifier', '>= 1.0.3'

  gem 'jquery-rails'
  gem 'jquery-ui-rails'
end

group :development do
  gem 'better_errors'
  gem 'capistrano'
end

group :production do
  gem 'unicorn'
end
