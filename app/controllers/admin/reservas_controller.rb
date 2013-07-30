class Admin::ReservasController < Admin::BaseController
  # GET /reservas
  # GET /reservas.json
  def index
    @reservas = Reserva.desc(:created_at)
    respond_with @reservas
  end

  # GET /reservas/1
  # GET /reservas/1.json
  def show
    @reserva = Reserva.includes(:outdoors, :checkin).find(params[:id])
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
    @reserva = Reserva.new(reserva_params)
    if @reserva.save
      if(params[:enviar_email])
        #Enviar e-mail sobre a nova reserva 
        ClienteMailer.new_reserva(@reserva).deliver
      end
        flash[:notice] = 'Reserva foi criado com sucesso e enviado um e-mail contendo informacoes sobre prazo ao cliente.'
      end

      respond_with @reserva, :location => admin_reservas_path
    end

  # PUT /reservas/1
  # PUT /reservas/1.json
  def update
    @reserva = Reserva.find(params[:id])
    flash[:notice] = 'Reserva foi atualizado com sucesso.' if @reserva.update_attributes(reserva_params)
    
    #Após confirmado uma vez, ele envia o e-mail
    if @reserva.status == 'confirmado' and @reserva.confirmado == false
      @reserva.confirmado = true
      @reserva.data_confirmacao = DateTime.now
      @reserva.save
      ClienteMailer.reserva_confirmed(@reserva).deliver
    end

    #Se for cancelado deletar o objeto
    if @reserva.status == 'cancelado'
      @reserva.destroy
      respond_with @reserva, :location => admin_reservas_path
    else
      respond_with @reserva, :location => edit_admin_reserva_path(@reserva)
    end
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
    @emails_clients = Cliente.all_emails.join(",")

    #Tentar selecionar todos os emails
      a = []
      (1..Cliente.all_emails.length).each{ |i| a << i}
      @array_emails_selected = a.join(",")

      p "Array olha ae: #{@array_emails_selected} --------------------------------------------"
    #Tentar selecionar todos os emails

    if(params.has_key?(:inicio_periodo) && params.has_key?(:termino_periodo) )
      @reservas = Reserva.seek_reserves_period(:inicio_reserva => params[:inicio_periodo], :termino_reserva => params[:termino_periodo])
      @outdoors = Reserva.outdoors_on_period(:reservas => @reservas)
    end
    render :partial => 'search_outdoor_available', :content_type => 'text/html'
  end

  def send_email_available_outdoors(options={})
    begin
      if(params.has_key?(:emails) or params.has_key?(:enviar_todos))
        result = ClienteMailer.available_outdoors(params).deliver        
      end
    end
    flash[:notice] = 'E-mail da disponibilidade enviado com sucesso. =]' 
    redirect_to new_admin_reserva_path
  end

  private
    def reserva_params
      params.require(:reserva).permit!
    end

end
