class ClienteMailer < ActionMailer::Base

  default from: "midiaexterna@midiaexterna.com"

  def available_outdoors(options={})
  	@inicio = options.fetch(:inicio_reserva, '')
    @fim = options.fetch(:termino_reserva, '')
    @mensagem = options.fetch(:mensagem, '')
    @outdoors = options.fetch(:outdoors, '').split(',')
    @usuario = Usuario.find(options[:usuario_id])
    @enviar_todos = options.fetch(:enviar_todos, '')

    if(@enviar_todos == "true")
      @emails = Cliente.all_emails
    else
      @emails = JSON.parse options.fetch(:emails, '')
    end

    @inicio_periodo = Date.parse(@inicio).strftime("%Y-%m-%d")
    @termino_periodo = Date.parse(@fim).strftime("%Y-%m-%d")
    @disponibilidade = "http://177.71.250.61/disponibilidade/#{@inicio_periodo}/#{@termino_periodo}"

    if(options[:anexo])
       @anexo = options.fetch(:anexo, '')
      attachments[@anexo.original_filename] = File.read(@anexo.tempfile.path) 
    end

    @emails_without_accents = Array.new
    @emails.each do |email|
      @emails_without_accents.push email.removeaccents
    end   
    
      mail({
        :to => @emails_without_accents,
        :bcc => ['Midia Externa <midiaexterna@midiaexterna.com>'],
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
        :bcc => ['Midia Externa <midiaexterna@midiaexterna.com>'],
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
        :bcc => ['Candido <candido@vendepublicidade.com.br>, Midia Externa <midiaexterna@midiaexterna.com>, Financeiro Midia externa <financeiro@midiaexterna.com>'],
        :subject => "[Midia Externa] Reserva confirmada: #{@inicio} a #{@fim}"
      })
  end

  def checkin_cliente(checkin)
    @checkin = checkin
    @inicio = @checkin.reserva.inicio_reserva.strftime("%d/%m/%Y")
    @fim = @checkin.reserva.termino_reserva.strftime("%d/%m/%Y")
    @usuario = @checkin.reserva.usuario

    @checkin_link = "http://177.71.250.61/checkin/#{@checkin.id}"

    mail({
        :to => @checkin.reserva.cliente.email,
        :bcc => ['Candido <candido@vendepublicidade.com.br>, Midia Externa <midiaexterna@midiaexterna.com>, Financeiro Midia externa <financeiro@midiaexterna.com>'],
        :subject => "[Midia Externa] Checkin dos Outdoors | #{@checkin.reserva.campanha} - #{@inicio} a #{@fim}"
      })
  end
end
