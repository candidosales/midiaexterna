class Admin::ReservasController < Admin::BaseController
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
    respond_with @reserva, :location => admin_reservas_path
  end

  # PUT /reservas/1
  # PUT /reservas/1.json
  def update
    @reserva = Reserva.find(params[:id])
    flash[:notice] = 'Reserva foi atualizado com sucesso.' if @reserva.update_attributes(params[:reserva])
    respond_with @reserva, :location => edit_admin_reserva_path(@reserva)
  end

  # DELETE /reservas/1
  # DELETE /reservas/1.json
  def destroy
    @reserva = Reserva.find(params[:id])
    @reserva.destroy
    respond_with @reserva, :location => admin_reservas_path
  end

  def search_outdoor_available
    @reserva = Reserva.new

    if(params.has_key?(:inicio_periodo) && params.has_key?(:termino_periodo) )
      @reservas = Reserva.seek_reserves_period(:inicio_reserva => params[:inicio_periodo], :termino_reserva => params[:termino_periodo])
      @outdoors = Reserva.outdoors_on_period(:reservas => @reservas)
    end
    render :partial => 'search_outdoor_available', :content_type => 'text/html'
  end

  def send_email_available_outdoors(options={})
    begin
      if(params.has_key?(:cliente_id))
        options[:outdoors] = params[:outdoors]
        options[:cliente_id] = params[:cliente_id]
        options[:inicio_periodo] = params[:inicio_reserva]
        options[:termino_periodo] = params[:termino_reserva]
        ClienteMailer.available_outdoors(options).deliver
      end 
      render :nothing => true, :status => 200
    rescue
      render :nothing => true, :status => 500
    end
  end
end
