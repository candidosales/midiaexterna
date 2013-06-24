class PublicController < ActionController::Base
 protect_from_forgery
 layout 'public'


 def available_outdoors
    @reserva = Reserva.new
    @emails_clients = Cliente.all_emails.join(",")

    @inicio_reserva   = Date.parse(params[:inicio_periodo]).strftime("%d/%m/%Y")
    @termino_reserva  = Date.parse(params[:termino_periodo]).strftime("%d/%m/%Y")

    if(params.has_key?(:inicio_periodo) && params.has_key?(:termino_periodo) )
      @reservas = Reserva.seek_reserves_period(:inicio_reserva => params[:inicio_periodo], :termino_reserva => params[:termino_periodo])
      @outdoors = Reserva.outdoors_on_period(:reservas => @reservas)
    end
  end

  def checkin
  	@checkin = Checkin.includes(:reserva).find(params[:id])
  end
end