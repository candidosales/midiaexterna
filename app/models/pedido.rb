class Pedido
  include Mongoid::Document
  field :criado_em, type: Time, default: Time.current

  field :inicio_reserva, type: Date
  field :termino_reserva, type: Date

  belongs_to :cliente, class_name: "Cliente"
  has_and_belongs_to_many :outdoors
 
end
