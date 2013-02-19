class Reserva
  include Mongoid::Document
  include Mongoid::MultiParameterAttributes 
  include Mongoid::Timestamps

  field :status, type: String, default: "pendente"
  field :valor, type: Money

  field :inicio_reserva, type: Date
  field :termino_reserva, type: Date

  field :campanha, type: String
  field :confirmado, type: Boolean, default: false
  field :data_confirmacao, type: DateTime

  belongs_to :cliente, class_name: "Cliente"

  #Usuario que cadastrou a reserva
  belongs_to :usuario, class_name: "Usuario"

  has_and_belongs_to_many :outdoors

  validates_presence_of :cliente, :valor, :campanha, :outdoors


  def self.seek_reserves_period(options={})
    inicio = options.fetch(:inicio_reserva, '')
    fim = options.fetch(:termino_reserva, '')
    includes(:outdoors).ne(status:'cancelado').gte(inicio_reserva: inicio).lte(termino_reserva: fim)
  end

  def self.outdoors_on_period(options={})
    reservas = options.fetch(:reservas, '')
    numeros = Array.new
    outdoors = nil

    if(reservas.count > 0 )
        reservas.each do |r|
          r.outdoors.each do |o|
            numeros.push o.numero
          end
        outdoors = Outdoor.nin(numero: numeros)
      end
    else
        outdoors = Outdoor.all
    end
    outdoors
  end
  
end

