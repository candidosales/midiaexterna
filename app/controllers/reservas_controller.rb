class ReservasController < ApplicationController
  # GET /reservas
  # GET /reservas.json
  def index
    @reservas = Reserva.all
    respond_with @reservas
  end

  # GET /reservas/1
  # GET /reservas/1.json
  def show
    @reserva = Reserva.includes(:outdoors).find(params[:id])
    respond_with @reserva
  end

  # GET /reservas/new
  # GET /reservas/new.json
  def new
    @reserva = Reserva.new
    respond_with @reserva
  end

  # GET /reservas/1/edit
  def edit
    @reserva = Reserva.find(params[:id])
  end

  # POST /reservas
  # POST /reservas.json
  def create
    @reserva = Reserva.new(params[:reserva])
    flash[:notice] = 'Reserva foi criado com sucesso.' if @reserva.save
    respond_with @reserva
  end

  # PUT /reservas/1
  # PUT /reservas/1.json
  def update
    @reserva = Reserva.find(params[:id])
    flash[:notice] = 'Reserva foi atualizado com sucesso.' if @reserva.update_attributes(params[:reserva])
    respond_with @reserva
  end

  # DELETE /reservas/1
  # DELETE /reservas/1.json
  def destroy
    @reserva = Reserva.find(params[:id])
    @reserva.destroy
    respond_with @reserva
  end

  def search_outdoor_available
    @reserva = Reserva.new
    numeros = Array.new
    if(params.has_key?(:inicio_periodo) && params.has_key?(:termino_periodo) )
      @reservas = Reserva.includes(:outdoors).gte(inicio_reserva: params[:inicio_periodo]).lte(termino_reserva: params[:termino_periodo])
      if(@reservas.count > 0 )
        @reservas.each do |r|
          r.outdoors.each do |o|
            numeros.push o.numero
          end
          @outdoors = Outdoor.nin(numero: numeros)
        end
      else
        @outdoors = Outdoor.all
      end
      @count = @outdoors.count
    end

    render :partial => 'search_outdoor_available', :content_type => 'text/html'

  end
end
