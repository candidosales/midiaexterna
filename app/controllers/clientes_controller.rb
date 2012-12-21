class ClientesController < ApplicationController
  # GET /clientes
  # GET /clientes.json
  def index
    @clientes = Cliente.all
    respond_with @clientes
  end

  # GET /clientes/1
  # GET /clientes/1.json
  def show
    @cliente = Cliente.find(params[:id])
    respond_with @cliente
  end

  # GET /clientes/new
  # GET /clientes/new.json
  def new
    @cliente = Cliente.new
    respond_with @cliente
  end

  # GET /clientes/1/edit
  def edit
    @cliente = Cliente.find(params[:id])
  end

  # POST /clientes
  # POST /clientes.json
  def create
    @cliente = Cliente.new(params[:cliente])
    flash[:notice] = 'Cliente foi criado com sucesso.' if @cliente.save
    respond_with @cliente
  end

  # PUT /clientes/1
  # PUT /clientes/1.json
  def update
    @cliente = Cliente.find(params[:id])
    flash[:notice] = 'Cliente foi atualizado com sucesso.' if @cliente.update_attributes(params[:cliente])
    respond_with @cliente
  end

  # DELETE /clientes/1
  # DELETE /clientes/1.json
  def destroy
    @cliente = Cliente.find(params[:id])
    @cliente.destroy
    respond_with @cliente
  end
end
