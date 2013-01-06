class UsuariosController < ApplicationController
  before_filter :authenticate_user!

  def show
  	@usuario = Usuario.find(params[:id])
  end
end
