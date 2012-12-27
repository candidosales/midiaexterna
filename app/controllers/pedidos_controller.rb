class PedidosController < ApplicationController
  # GET /pedidos
  # GET /pedidos.json
  def index
    @pedidos = Pedido.all
    respond_with @pedidos
  end

  # GET /pedidos/1
  # GET /pedidos/1.json
  def show
    @pedido = Pedido.find(params[:id])
    respond_with @pedido
  end

  # GET /pedidos/new
  # GET /pedidos/new.json
  def new
    #@pedido = Pedido.new
    #respond_with @pedido
    if(params.has_key?(:inicio_periodo))
      params[:inicio_periodo]
    end
  end

  # GET /pedidos/1/edit
  def edit
    @pedido = Pedido.find(params[:id])
  end

  # POST /pedidos
  # POST /pedidos.json
  def create
    @pedido = Pedido.new(params[:pedido])
    @pedido.outdoor_ids.each do |o|
      outdoor = Outdoor.find(o);
      outdoor.status = "reservado";
      outdoor.update_attributes();
    end
    flash[:notice] = 'Pedido foi criado com sucesso.' if @pedido.save
    respond_with @pedido
  end

  # PUT /pedidos/1
  # PUT /pedidos/1.json
  def update
    @pedido = Pedido.find(params[:id])
    flash[:notice] = 'Pedido foi atualizado com sucesso.' if @pedido.update_attributes(params[:pedido])
    respond_with @pedido
  end

  # DELETE /pedidos/1
  # DELETE /pedidos/1.json
  def destroy
    @pedido = Pedido.find(params[:id])
    @pedido.destroy
    respond_with @pedido
  end

  def search_outdoor_available
    puts "Aquiooh"+params[:authenticity_token]

    if(params.has_key?(:inicio_periodo))
      @resposta = params[:inicio_periodo]
    else
      @resposta = Pedido.last.status
    end

    render :partial => 'search_outdoor_available', :content_type => 'text/html'

  end
end
