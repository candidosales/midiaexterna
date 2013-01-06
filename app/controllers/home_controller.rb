class HomeController < ApplicationController
  def index
  	@usuarios = Usuario.all
  end
end
