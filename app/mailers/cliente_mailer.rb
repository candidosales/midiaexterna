class ClienteMailer < ActionMailer::Base
  default from: "midiaexterna@midiaexterna.com"

  def available_outdoors(options={})
  	@inicio = options.fetch(:inicio_periodo, '')
    @fim = options.fetch(:termino_periodo, '')
    @outdoors = options.fetch(:outdoors, '').split(',')
    
    @usuario = Usuario.find(options[:usuario_id])
    @cliente = Cliente.find(options[:cliente_id])
    
    	mail({
    		:to => @cliente.email,
    		:bcc => ['Candido <candido@vendepublicidade.com.br>'],
    		:subject => "[Midia Externa] Disponibilidade de #{@inicio} a #{@fim}"
    	})
	end

  def new_reserva(reserva)
    @reserva = Reserva.find(reserva)
    @inicio = @reserva.inicio_reserva.strftime("%d/%m/%Y")
    @fim = @reserva.termino_reserva.strftime("%d/%m/%Y")
    @cliente = @reserva.cliente
    @outdoors= @reserva.outdoors
    @usuario = @reserva.usuario

    mail({
        :to => @reserva.cliente.email,
        :bcc => ['Candido <candido@vendepublicidade.com.br>'],
        :subject => "[Midia Externa] Voce possui uma nova reserva de #{@inicio} a #{@fim}"
      })
  end

  def reserva_confirmed(reserva)
    @reserva = Reserva.find(reserva)
    @inicio = @reserva.inicio_reserva.strftime("%d/%m/%Y")
    @fim = @reserva.termino_reserva.strftime("%d/%m/%Y")
    @cliente = @reserva.cliente
    @outdoors= @reserva.outdoors
    @usuario = @reserva.usuario

    mail({
        :to => @reserva.cliente.email,
        :bcc => ['Candido <candido@vendepublicidade.com.br>'],
        :subject => "[Midia Externa] Reserva confirmada: #{@inicio} a #{@fim}"
      })
  end
  
end
