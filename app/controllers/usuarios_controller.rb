class UsuariosController < ApplicationController
  before_filter :authenticate_usuario!

  def index
    @usuarios = Usuario.all
    respond_with @usuarios
  end

  def show
  	@usuario = Usuario.find(params[:id])
  end

  # GET /usuarios/new
  # GET /usuarios/new.json
  def new
    @usuario = Usuario.new
    respond_with @usuario
  end

  # POST /usuarios
  # POST /usuarios.json
  def create
    @usuario = Usuario.new(params[:usuario])
    flash[:notice] = 'Usuario foi criado com sucesso.' if @usuario.save
    respond_with @usuario, :location => usuarios_path
  end
  
end
