class ClienteMailer < ActionMailer::Base

  default from: "midiaexterna@midiaexterna.com"

  def available_outdoors(options={})
  	@inicio = options.fetch(:inicio_reserva, '')
    @fim = options.fetch(:termino_reserva, '')
    @mensagem = options.fetch(:mensagem, '')
    @anexo = options.fetch(:anexo, '')
    @outdoors = options.fetch(:outdoors, '').split(',')
    @emails = JSON.parse options.fetch(:emails, '')

    @emails_without_accents = Array.new
    
    @emails.each do |email|
      @emails_without_accents.push email.removeaccents
    end
    
    @usuario = Usuario.find(options[:usuario_id])

    attachments[@anexo.original_filename] = File.read(@anexo.tempfile.path)
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
  
end
