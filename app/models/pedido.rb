class Pedido
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes 
  include Mongoid::Timestamps

  field :status, type: String, default: "aberto"
  field :valor, type: Money

  field :inicio_reserva, type: Date
  field :termino_reserva, type: Date

  belongs_to :cliente, class_name: "Cliente"
  has_and_belongs_to_many :outdoors
 
  def periodo_reserva
  	%{#{inicio_reserva} ate #{termino_reserva}}
  end

  def outdoors_selecionados
  	
  end

  def outdoors_abertos_periodo(options={})
    inicio = options.fetch(:inicio_reserva, '');
    fim = options.fetch(:termino_reserva, '');
   # p = Pedido.find({}, outdoors: {$and: [{inicio_reserva: {$gte: inicio}, {termino_reserva: {$lte: fim} }]})
  end
  
end
