class ClienteMailer < ActionMailer::Base
  default from: "candidosg@gmail.com"

  def available_outdoors(options={})
  	@inicio = options.fetch(:inicio_periodo, '')
    @fim = options.fetch(:termino_periodo, '')
    @outdoors = options.fetch(:outdoors, '').split(',')
    
    @cliente = Cliente.find(options[:cliente_id])
    
    	mail({
    		:to => @cliente.email,
    		:bcc => ['Cândido <candido@vendepublicidade.com.br>'],
    		:subject => "[Midia Externa] Disponibilidade de #{@inicio} a #{@fim}"
    	})
	end
  
end
